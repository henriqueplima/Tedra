//
//  CenaExercicioOperadores1.m
//  ProjetoFinal
//
//  Created by Henrique Pereira de Lima on 17/07/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "CenaExercicioOperadores1.h"
#import <stdlib.h>


@implementation CenaExercicioOperadores1{
    NSMutableArray *expressoes;
    Calculador *calculador;
    SKNode *nodeClicado;
    SpriteLabelNode *operador;
    SKSpriteNode *espacoClicado;
    int quantidadeOperadores;
}




- (id)init{
    
    self = [super init];
    
    if (self) {
        self.backgroundColor = [SKColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
        
        
        
        
        //allocando calculador
        calculador = [[Calculador alloc]init];
        
        
        expressoes = [NSMutableArray array];
        
        quantidadeOperadores = 6;
        
        [self configuraNodes];
        
    

        [self criaEnunciado];
    }
    return self;

    
}

-(void)didMoveToView:(SKView *)view{
    
    
    //CRIA O GESTURE E A TEXT FIELD
    
    //GESTURE
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGestureRecognizer:)];
    //[longPress setMinimumPressDuration:1.5];
    //[longPress setNumberOfTouchesRequired:2];
    [longPress setNumberOfTouchesRequired:1];
    [longPress setMinimumPressDuration:1];
    [self.view addGestureRecognizer:longPress];
    
}


- (void)criaEnunciado{
    
    SKLabelNode *enunciado1 = [[SKLabelNode alloc]initWithFontNamed:@"HeadLine"];
    SKLabelNode *enunciado2 = [[SKLabelNode alloc]initWithFontNamed:@"HeadLine"];
    
    
    CGPoint posicao = CGPointMake(400, 850);
    CGPoint posicao2 = posicao;
    posicao2.y -= enunciado1.fontSize * 1.2 ;
    
    NSString *texto1 = @"Arraste cada operador para";
    NSString *texto2 = @"dentro da caixa adequada";
    
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
    finalizar.position = CGPointMake(400, 80);
    finalizar.fontSize = 70;
    [finalizar setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    finalizar.name = @"botaoFinalizar";
    
    [self addChild:finalizar];
    
    
    
}


- (SpriteOperadorNode *)criaSpritecomConteudo:(NSString *)operador1{
    
    
    int n;
    
    
    //SORTEIA VALORES
    
    n = arc4random() % 10 + 1;
    NSString *valor1 = [NSString stringWithFormat:@"%d",n];
    
    n = arc4random() % 10 + 1;
    
    NSString *valor2 = [NSString stringWithFormat:@"%d",n];
    
    
    //chamando o calculador para retornar o resultado da operacao
    
    NSString *resultado = [calculador calculaOperador:operador1 numero1:valor1 numero2:valor2];
    
    
    SpriteOperadorNode *sprite = [[SpriteOperadorNode alloc]init];
    [sprite setLabelValor1:valor1];
    [sprite setLabelValor2:valor2];
    [sprite setLabelResultado:resultado];
    //        NSString *temp = operador.text;
    //        [spriteOperador setLabelOperador:temp];
    sprite.name = @"sprite";

    
    return sprite;
    
    
    
    
    //COMENTARIO DE CONCATENACAO DE STRING (TALVEZ NECESSARIO PARA CONSULTA)
    //NSArray *strings = [[NSArray alloc]initWithObjects:@"=",aux ,nil];
    //resultado = [[SpriteLabelNode alloc]initWithType:@"resultado" texto:[strings componentsJoinedByString:@" "]];
    
}


- (SpriteLabelNode *)criaLabel:(NSString *)texto name:(NSString*)name{
    
    SpriteLabelNode *aux = [[SpriteLabelNode alloc]initWithType:nil texto:texto];
    aux.name = name;
    aux.fontSize = 65;
    
    return aux;
    
}

- (void)configuraNodes{
    
    NSArray *operadores = [NSArray arrayWithObjects:@">", @"<",@"==",@"!=",@">=",@"<=",@"+",@"-",@"*",@"/",nil];
    
    NSMutableArray *opcoes = [NSMutableArray array];
    
    
    
    
    CGPoint posicaoInicial = CGPointMake(200, 650);
    CGPoint posicaoMutavel = posicaoInicial;
    
    
    
    for (int i = 0; i < quantidadeOperadores; i++) {
        
        int  n = arc4random() % operadores.count;
        
        SpriteLabelNode *operadorLabel = [self criaLabel:[operadores objectAtIndex:n] name:@"labelOperador"];
        [opcoes addObject:operadorLabel];
        
        
        SpriteOperadorNode *spriteOperador = [self criaSpritecomConteudo:operadorLabel.text];
        
        SKSpriteNode *espaco = [[SKSpriteNode alloc]initWithImageNamed:@"fundo-transparente.png"];
        espaco.position = posicaoMutavel;
        [espaco setPosition:CGPointMake(posicaoMutavel.x, posicaoMutavel.y + 60)];
        espaco.size = CGSizeMake(105, 105);
        espaco.name = @"espaco";
        
        spriteOperador.position = posicaoMutavel;
        
        NSDictionary *expressao = @{
                                    @"espaco":espaco,
                                    @"spriteOperador":spriteOperador
                                    };
        
        [expressoes addObject:expressao];
        
        operadorLabel.fontName = @"Helvetica";
        [self addChild:spriteOperador];
        [spriteOperador iniciarAnimacaoAbrir];
        [self addChild:espaco];
        
        if (((i+1) % 2) != 0) {
            posicaoMutavel.x = 550;
        }else{
            posicaoMutavel.x = posicaoInicial.x;
            posicaoMutavel.y -= 200;
        }
        
        
    }
    
    opcoes = [self embaralhaEposicionaLabels:opcoes];
    
    
    
}


- (NSMutableArray *)embaralhaEposicionaLabels :(NSMutableArray *)antigo{
    
    CGPoint posicaoInicial = CGPointMake(50, 100);
    CGPoint posicaoMutavel = posicaoInicial;
    
    
    int n;
    NSMutableArray *vetorEmbaralhado = [NSMutableArray array];
    
    while (antigo.count > 0) {
        n = arc4random() % antigo.count;
        
        SpriteLabelNode *labelOperador = [antigo objectAtIndex:n];
        [labelOperador setPosition:posicaoMutavel];
        [labelOperador setPosicaoInicial:posicaoMutavel];
        
        
        [vetorEmbaralhado addObject:labelOperador];
        [antigo removeObjectAtIndex:n];
        [self addChild:labelOperador];
        posicaoMutavel.x += (labelOperador.fontSize * 2);
        
    }
    
    
    
    
    return vetorEmbaralhado;
    
    
    
}


- (void)posicionamento:(NSMutableArray *)vetor{
    
    CGPoint posicaoInicial = CGPointMake(50, 100);
    CGPoint posicaoMutavel = posicaoInicial;
    
    posicaoMutavel.x = posicaoInicial.x + 10;
    posicaoMutavel.x = self.frame.size.width * 80;
    
    for (SpriteLabelNode *labelOperador in vetor) {
        [labelOperador setPosition:posicaoMutavel];
        [labelOperador setPosicaoInicial:posicaoMutavel];
        
        [self addChild:labelOperador];
    }
    
    
    
    
}



- (void)longPressGestureRecognizer:(UILongPressGestureRecognizer *)recognizer{
    
    //RECONHECE O GESTURE DE LONGPRESS
    
    
    if (recognizer.state == UIGestureRecognizerStateBegan && [nodeClicado.name isEqualToString:@"espaco"]){
        
        //HABILITA A TEXTFIELD
        
        for (NSDictionary *expresssao in expressoes) {
            
            SKSpriteNode *espaco = [expresssao objectForKey:@"espaco"];
            SpriteOperadorNode *spriteOperador = [expresssao objectForKey:@"spriteOperador"];
            if ([espaco isEqual:nodeClicado] && ![[spriteOperador getOperador] isEqualToString:@""]) {
                
                operador = [self criaLabel:[spriteOperador getOperador] name:@"labelOperador"];
                
                [operador setPosicaoInicial:CGPointMake(400, 50)];
                operador.position = operador.posicaoInicial;
                [spriteOperador setLabelOperador:@""];
                [self addChild:operador];
                quantidadeOperadores++;
                NSLog(@"quantidade %d",quantidadeOperadores);
                

                
            }
            
            
            
            
        }
        
        
        
        
        
    }
    
    
    
}


- (void)animacaoOperadorErrado:(SpriteLabelNode *)conteudoAtivo{
    //DEIXA A LABEL VERMELHA E A COLOCA NA SUA COORDENADA DE INICIO
    
    conteudoAtivo.fontColor = [UIColor redColor];
    SKAction *animacaoVoltar = [SKAction moveTo:conteudoAtivo.posicaoInicial duration:0.5];
    [conteudoAtivo runAction:animacaoVoltar completion:^{
        [conteudoAtivo removeAllActions];
        conteudoAtivo.fontColor = [UIColor whiteColor];
    }];
    
}



-(void)corrigirExercicio:(SpriteOperadorNode*)spriteOperador conteudoAtivo:(SpriteLabelNode *)conteudoAtivo{
    
    
    //PEGA OS VALORES DO SPRITENODE
    
    NSString *valor1 = [spriteOperador getValor1];
    NSString *valor2 = [spriteOperador getValor2];
    NSString *resultado = [spriteOperador getResultado];
    
    //CHAMA O CALCULADOR E SE A EXPRESSAO ESTA CORRETA
    
    //PASSA O OPERADOR PARA O PONTEIRO OPERADORDOSPRITE
    NSString *operadorDoSprite = [spriteOperador getOperador];
    
    //VERIFICA SE JA EXISTE UM OPERADOR NESSE SPRITE NODE (SE TIVER ELE NAO DEIXA POR OUTRO)
    //CHAMA O CALCULADOR E VERIFICA SE A RESPOSTA ESTA CERTA
    
    if ([operadorDoSprite isEqualToString:@""]  && [resultado isEqualToString:[calculador calculaOperador:conteudoAtivo.text numero1:valor1 numero2:valor2]]) { //se a resposta do calculador for a mesma da expressao
        
        [spriteOperador setLabelOperador:conteudoAtivo.text];
        [self runAction:[SKAction playSoundFileNamed:@"correto.aiff" waitForCompletion:NO]];
        [conteudoAtivo removeFromParent];
        conteudoAtivo.dentro = YES;
        quantidadeOperadores--;
        NSLog(@"quantidade %d",quantidadeOperadores);
        
    }else{
        //OPERADOR NO LUGAR ERRADO
        [self animacaoOperadorErrado:conteudoAtivo];
        [self runAction:[SKAction playSoundFileNamed:@"errado.wav" waitForCompletion:NO]];
    }

    //VERIFICA SE O EXERCICIO JA ACABOU
    
    if (quantidadeOperadores <= 0) {
        NSLog(@"exercicio concluido");
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"ExeOperadores1"];
        [self criarBotaoFinalizar];
    }

    
}





- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //criando toque e posicao
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    nodeClicado = [self nodeAtPoint:location];
    
    if ([nodeClicado.name isEqualToString:@"botaoFinalizar"]) {
        
        [self.myDelegate exercicioFinalizado];
        
    }
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //se move estiver YES entao pode mover o NODE
    
    //if (move) {
        
        //identificando toque e posicao
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInNode:self];
        
        //setando posicao no NODE
        if ([nodeClicado.name isEqualToString:@"labelOperador"]) {
            [nodeClicado setPosition:location];
        }
        
            
       
   // }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    
    if ([nodeClicado.name isEqualToString:@"labelOperador"] && nodeClicado) {
        
        SpriteLabelNode *conteudoAtivo = (SpriteLabelNode *)nodeClicado;
        
        conteudoAtivo.dentro = NO;
        
        for (NSDictionary *expressao in expressoes) { //Ao soltar o node de resposta em algum lugar varre o vetor de caixas para descobrir sobre quem está
            
            SKSpriteNode *espaco = [expressao objectForKey:@"espaco"];
            
            
            
            //COORDENADAS PARA A CAIXA
            
            float xInicio = espaco.frame.origin.x;
            float xFim = xInicio + espaco.frame.size.width;
            //float xMeio = (xInicio + xFim)/2;
            float yInicio = espaco.frame.origin.y;
            float yFim = yInicio + espaco.frame.size.height;
            //float yMeio = (yInicio + yFim)/2;
            
            
            //VERIFICA SE O NODE MOVIDO ESTA DENTRO DA CAIXA
            
            if ((conteudoAtivo.position.x > xInicio && conteudoAtivo.position.x < xFim)&&(conteudoAtivo.position.y >yInicio && conteudoAtivo.position.y < yFim)) { // Verifica se o nó "resposta" está sobre alguma caixa
                
               
                // CHAMA O MÉTODO CORRIGIR PASSANDO O SPRITEOPERADORNODE E O CONTEUDO ATIVO COMO PARAMETRO
                
                [self corrigirExercicio:[expressao objectForKey:@"spriteOperador"] conteudoAtivo:conteudoAtivo];
                
                
            }

    
        }
        
        
    }
    
    
   // move = NO;
    
}



@end
