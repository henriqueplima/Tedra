//
//  MyScene.m
//  Exercicio
//
//  Created by Henrique Pereira de Lima on 07/07/14.
//  Copyright (c) 2014 Henrique Pereira de Lima. All rights reserved.
//

#import "CenaExercicioVariavel1.h"

@implementation CenaExercicioVariavel1{
    
}



-(id)init{
    self = [super init];
    
    if (self) {
        self.backgroundColor = [SKColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
        
        
        //CONFIGURANDO CODIGO EM PORTUGOL QUE APARECE QUANDO O USUARIO ACERTA
        codigo = [[SKLabelNode alloc]initWithFontNamed:@"HeadLine"];
        codigo.position = CGPointMake(50, 100);
        [codigo setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
        [self addChild:codigo];
        
        
        //CHAMANDO METODOS QUE CRIAM E ADICIONAM NODES
        
        [self criaEnunciado];
        [self criarCaixas];
        [self criaLabelsConteudo];
        
        _corretos = 0;
        
    }
    return self;
}

- (void)criaEnunciado{
    
    //CRIA ENUNCIADO DO EXERCICIO
    
    
    SKLabelNode *enunciado1 = [[SKLabelNode alloc]initWithFontNamed:@"HeadLine"];
    SKLabelNode *enunciado2 = [[SKLabelNode alloc]initWithFontNamed:@"HeadLine"];

    
    CGPoint posicao = CGPointMake(400, 850);
    CGPoint posicao2 = posicao;
    posicao2.y -= enunciado1.fontSize * 1.2 ;
    
    NSString *texto1 = @"Arraste cada conteudo para";
    NSString *texto2 = @"dentro da variável adequada";
    
    [enunciado1 setText:texto1];
    [enunciado2 setText:texto2];
    [enunciado1 setPosition:posicao];
    [enunciado2 setPosition:posicao2];
    
    [self addChild:enunciado1];
    [self addChild:enunciado2];
    
}

- (void)criarBotaoFinalizar{
    
    //CRIA BOTAO PARA VOLTAR A LISTA DE EXERCICIOS
    
    
    SKLabelNode *finalizar = [[SKLabelNode alloc]init];
    finalizar.text = @"Finalizar";
    finalizar.position = CGPointMake(500, 80);
    finalizar.fontSize = 70;
    [finalizar setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    finalizar.name = @"botaoFinalizar";
    
    [self addChild:finalizar];
    
    
    
}

- (void)criaLabelsConteudo{
    
    //CRIA LABELS DE CONTEUDO QUE SERAO ARRASTADAS PELO USUARIO
    
    NSMutableArray *conteudos = [NSMutableArray array];
    
    
    //AS LABELS SAO CRIADAS CONFIGURADAS ATRAVES DE UM METODO E SAO ARMAZENADAS NO VETOR CONTEUDOS
    for (int i = 0; i < 4; i++) {
        SpriteLabelNode *conteudo = [[SpriteLabelNode alloc]init];
        conteudo.name = @"conteudo";
        [self configuraLabel:conteudo indice:i];
        [conteudos addObject:conteudo];
    }
    
    
    

    //EMBARALHANDO LABELS DO VETOR
    conteudos = [self embaralha:conteudos];
    
    //INSERINDO POSICOES E TAMANHO EM CADA LABEL
    
    CGPoint posicaoOriginal = CGPointMake(650,  650);
    CGPoint posicao = posicaoOriginal;
    int font =  30;
    
    for (int i = 0; i < conteudos.count; i++) {
        
        [[conteudos objectAtIndex:i] setFontSize:font];
        
        [[conteudos objectAtIndex:i] setPosition:posicao];
        [[conteudos objectAtIndex:i] setPosicaoInicial:posicao];
        
        
        posicao.y -= (font * 5) ;
        
        [self addChild:[conteudos objectAtIndex:i]];
        
    }
    
    
}

- (void)criarCaixas{
    
    //METODO QUE CRIAR AS CAIXAS
    
    vetorCaixas = [NSMutableArray array];
    CGSize tamanho = CGSizeMake(250, 257);
    
    //RECEBE AS CAIXAS DO METODO RETORNA CAIXA E ADICIONA NO VETORCAIXAS
    for (int i = 0; i < 4; i++) {
        SpriteCaixaNode *caixa = [self retornaCaixaPreConfigurada:tamanho indice:i];
        [caixa setLabelEndereco:i+1];
        [vetorCaixas addObject:caixa];
    }
    
    
    //EMBARALHA A ORDEM DAS CAIXAS DO VETOR
    vetorCaixas = [self embaralha:vetorCaixas];
    
    //INSERINDO POSICIONAMENTO
    
    CGPoint primeiraPosicao = CGPointMake( 200.0,  630.0);
    CGPoint posicao = primeiraPosicao;
    
    for (int i = 0; i < vetorCaixas.count; i++) {
        
        // caixas do lado direito
        if (i == 2) {
            
            posicao = primeiraPosicao;
            posicao.x += tamanho.width * 1.0;
            [[vetorCaixas objectAtIndex:i] setPosition:posicao];
            posicao.y -= tamanho.height * 1.15;
            
            
            
        }else{
            [[vetorCaixas objectAtIndex:i] setPosition:posicao];
            posicao.y -= tamanho.height * 1.15;
            
        }
        
        // inserindo nó
        [[vetorCaixas objectAtIndex:i] iniciarAnimacaoIntroducao];
        [self addChild:[vetorCaixas objectAtIndex:i]];
    }
    
}

- (void)configuraLabel:(SpriteLabelNode *)label indice :(int)indice{
    
    //CONFIGURA AS LABELS CONTEUDOS UTILIZANDO O GERADOR QUE RETORNARA SEU TEXTO CONFORME O INDICE PASSADO COMO REFERENCIA
    
    //ESSE METODO É CHAMADO NO METODO "CRIA LABELS CONTEUDO"
    
    Gerador *gerador = [[Gerador alloc]init];
    
    
    
    switch (indice) {
        case 0:
            label.tipo = @"inteiro";
            label.text = [gerador retornaValorInteiro:1 ate:50];
            break;
        case 1:
            label.tipo = @"real";
            label.text = [gerador retornaValorFloat:1 ate:200];
            break;
        case 2:
            label.tipo = @"caractere";
            label.text = [gerador retornaValorCaractere];
            break;
        case 3:
            label.tipo = @"logico";
            label.text = [gerador retornaValorLogico];
            break;
            
            
        default:
            break;
    }
    
    
}

- (SpriteCaixaNode *)retornaCaixaPreConfigurada:(CGSize)size indice:(int)indice{
    
    //CRIA E RETORNA A CAIXA COM UM NOME E TIPO DEFINIDO
    //ESSE METODO É CHAMADO PELO METODO "CRIAR CAIXA"
    //UTILIZA O GERADOR
    
    Gerador *gerador = [[Gerador alloc]init];
    
    switch (indice) {
            
            //CAIXA DO TIPO INTEIRO
        case 0:
            return [[SpriteCaixaNode alloc]initWithConteudo:@" " nome:[gerador retornaNomeVariavel:@"inteiro"] tipo:@"inteiro" tamanho:size];
            
            
            break;
            
        case 1:
            
            return [[SpriteCaixaNode alloc]initWithConteudo:@" " nome:[gerador retornaNomeVariavel:@"real"] tipo:@"real" tamanho:size];
            
            
            
            break;
            
        case 2:
            
            
            return [[SpriteCaixaNode alloc]initWithConteudo:@" " nome:[gerador retornaNomeVariavel:@"caractere"] tipo:@"caractere" tamanho:size];
            
            
            
            break;
            
        case 3:
            return [[SpriteCaixaNode alloc]initWithConteudo:@" " nome:[gerador retornaNomeVariavel:@"logico"] tipo:@"logico" tamanho:size];
            
            break;
            
        default:
            return nil;
            break;
    }
    
}

- (NSMutableArray *)embaralha :(NSMutableArray *)antigo{
    
    //EMBARALHA OS ITENS DE UM VETOR
    
    int n;
    NSMutableArray *vetorEmbaralhado = [NSMutableArray array];
    
    while (antigo.count > 0) {
        n = arc4random() % antigo.count;
        
        [vetorEmbaralhado addObject:[antigo objectAtIndex:n]];
        [antigo removeObjectAtIndex:n];
    }
    
    
    
    
    return vetorEmbaralhado;
    
    
    
}

-(void)traduzParaPortugol: (SpriteCaixaNode *)c{
    
    //ESSE METODO ESCREVE O CODIGO EM PORTUGOL CADA VEZ QUE O USUARIO INSERE O CONTEUDO NA VARIAVEL CERTA
    
    //PEGA OS TEXTOS CONFORME A CAIXA E O CONTEUDO ATIVO QUE É O CONTEUDO INSERIDO
    NSString *nomeVariavel = [c retornaNome];
    NSString *tipoVariavel = [c retornaTipo];
    NSString *valor = [conteudoAtivo text];
    
    
    //CONCATENA STRING
    
    NSArray *strings = [[NSArray alloc]initWithObjects:tipoVariavel ,nomeVariavel,@"<-",valor ,nil];
    
    NSString *portugol = [strings componentsJoinedByString:@" "];
    //ADICIONA NA LABEL CODIGO
    codigo.text = portugol;
}

-(void)verificaConclusao{
    
    //VERIFICA SE O EXERCICIO JA ACABOU
    
    if (_corretos == 4) {
        
        //EXERCICIO CONCLUIDO
        //PASSA YES PARA O USERDEFAULTS
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"ExeVariavel1"];
        
        //CRIA LABEL PARABENS
        SKLabelNode *parabens = [[SKLabelNode alloc]init];
        parabens.text = @"Parabéns";
        parabens.position = CGPointMake(400, 500);
        parabens.fontSize = 90;
        [self addChild:parabens];
        
        //CRIA BOTAO FINALIZAR
        [self criarBotaoFinalizar];
        
        
        
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];

    
    
    
    //VERIFICA CONTEUDO CLICADO
    
    
    if([node.name isEqualToString:@"conteudo"]){
        
        
        conteudoAtivo = (SpriteLabelNode *) [self nodeAtPoint:location];
    }else if ([node.name isEqualToString:@"botaoFinalizar"]){
        //VOLTA PARA A TELA ANTERIOR
        [self.myDelegate exercicioFinalizado];
    }
    
    
    
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    //SE A POSIÇÃO QUE FOI CLICADA É A MESMA DO SPRITE DA CAIXA, O SPRITE É MOVIDO
    
    if ([conteudoAtivo.name isEqualToString:@"conteudo"]) {
    
        [conteudoAtivo setPosition:location];
        
    }else{
        conteudoAtivo = nil;
    }

    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (conteudoAtivo) {
       
        for (SpriteCaixaNode * c in vetorCaixas) { //Ao soltar o node de resposta em algum lugar varre o vetor de caixas para descobrir sobre quem está
            float xInicio = c.frame.origin.x;
            float xFim = xInicio + c.frame.size.width;
            //float xMeio = (xInicio + xFim)/2; PARA O FUTURO
            float yInicio = c.frame.origin.y;
            float yFim = yInicio + c.frame.size.height;
            //float yMeio = (yInicio + yFim)/2; PARA O FUTURO
            
            if ((conteudoAtivo.position.x > xInicio && conteudoAtivo.position.x < xFim)&&(conteudoAtivo.position.y >yInicio && conteudoAtivo.position.y < yFim)) { // Verifica se o nó "resposta" está sobre alguma caixa
                
                if ([[conteudoAtivo tipo] isEqualToString: [c retornaTipo]]) { // Caso a resposta esteja correta (Nó de resposta no local correto)
                    _corretos++;
                    [self runAction:[SKAction playSoundFileNamed:@"correto.aiff" waitForCompletion:NO]];
                    [c setLabelConteudo:conteudoAtivo.text];
                    
                    //Ação a ser feita caso a resposta esteja correta
                    [c executaSprite];
                    [self traduzParaPortugol:c];
                    [conteudoAtivo removeFromParent];
                    
                    conteudoAtivo = nil;
                    [self verificaConclusao];
                
                }else{
                    [self runAction:[SKAction playSoundFileNamed:@"errado.wav" waitForCompletion:NO]];
                    conteudoAtivo.fontColor = [UIColor redColor];
                    SKAction *animacaoVoltar = [SKAction moveTo:conteudoAtivo.posicaoInicial duration:0.5];
                    [conteudoAtivo runAction:animacaoVoltar completion:^{
                        [conteudoAtivo removeAllActions];
                        conteudoAtivo.fontColor = [UIColor whiteColor];
                    }];
                }
                
                //[conteudoAtivo setPosition:CGPointMake(xMeio, yMeio)]; //Coloca o node no centro da caixa
            }
            
        }
    }
}



@end
