//
//  AnimaCondSimples.m
//  ProjetoFinal
//
//  Created by Felipe Costa Nascimento on 26/07/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "AnimaCondSimples.h"


@implementation AnimaCondSimples

-(id)initWithCondicao:(NSString*)condicao{
    if(self = [super init]){
        
        NSArray *condicoes;
        
        //É VERIFICADO COMO SERÁ A ESTRUTURA DA CONDICIONAL
        //PARA QUE SEJA CRIADO UM VETOR COM OS OBJETOS NECESSÁRIOS PARA ESTA ESTRUTUA
        if([condicao isEqualToString:@"SE"]){
            condicoes = [NSArray arrayWithObjects:@"se", nil];
            
        }else if([condicao isEqualToString:@"SE-SENAO"]){
            condicoes = [NSArray arrayWithObjects:@"se", @"senao", nil];
        
        }else if([condicao isEqualToString:@"SE-SENAOSE"]){
            condicoes = [NSArray arrayWithObjects:@"se", @"senaoSe", nil];
        
        }else if([condicao isEqualToString:@"SE-SENAOSE-SENAO"]){
            condicoes = [NSArray arrayWithObjects:@"se", @"senaoSe", @"senao", nil];
            
        }
        
        [self inicializarClasseComCondicoes :condicoes];
        [self inicializarSaidadeDados];
    }
    
    return self;
}


-(void)inicializarClasseComCondicoes:(NSArray*)condicoes{
    [self setBackgroundColor:[SKColor whiteColor]];
    contadorDeTeste = 0;
    [self inicializarBotaoIniciarAnimacao];
    [self inicializarBotaoAtualizar];
    [self inicializarCondicoes:condicoes];
    
    
    [self inicializarParametros];
    
}



-(void)inicializarCondicoes:(NSArray*)condicoes{
    //PRIMEIRAMENTE VERIFICA SE O ARRAY EXISTE
    if(!condicoes){
        return;
    }
    
    spritesCondicao = [[NSMutableArray alloc] init];
    NSString *tipoCondicao;
    CGPoint posicao = CGPointMake(180, 560);
    
    //O LAÇO PERCORRE INSERINDO UMA NOVA CONDIÇÃO NO VETOR CONFORME O TAMANHO DO VETOR PASSADO POR PARAMETRO
    for(int i=0; i<condicoes.count; i++){
        tipoCondicao = [condicoes objectAtIndex:i];

        SpriteCondicaoNode *node = [self criarCondicaoNode:tipoCondicao];
        
        if(i == 2){
            posicao.y -= node.size.height / 0.95;
        
        }else{
            posicao.y -= node.size.height / 1.5;
        }
            
        
        [node setPosition:posicao];
        [spritesCondicao addObject:node];
        
        
        
    }
}


//PERCORRE O VETOR DE SpriteCondicaoNode DEFININDO OS VALORES ALEATÓRIOS
-(void)inicializarParametros{
    for(SpriteCondicaoNode* node in spritesCondicao){

        
        NSString* valor1 = [self gerarValoresAleatorios];
        NSString* valor2 = [self gerarValoresAleatorios];
        NSString* operador = [self gerarOperadoresAleatorios];
        
        [node criarValores:valor1 eOperador:operador eValor2:valor2 resultado:valor1];
        
        
    }
}

-(NSString*)gerarValoresAleatorios{
    //DEFINE OS VALORES, OPERADOR E RESULTADO
    Gerador *gerador = [[Gerador alloc] init];
    
    return [gerador retornaValorInteiro:0 ate:20];
}

-(NSString*)gerarOperadoresAleatorios{
    //DEFINE OS VALORES, OPERADOR E RESULTADO
    Gerador *gerador = [[Gerador alloc] init];
    
    return [gerador retornaOperadorRelacional];
    
}

-(void)inicializarSaidadeDados{
    console = [[SaidaDeDados alloc] init];
    [console setPosition:CGPointMake(594, 83)];
    [self addChild:console];
    //[console exibeTexto:@">"];
    
}

-(SpriteCondicaoNode*)criarCondicaoNode:(NSString*)tipo{
    SpriteCondicaoNode *condicaoNode = [[SpriteCondicaoNode alloc] initWithType:tipo];
    condicaoNode.myDelegate = self;
    [self addChild:condicaoNode];
 
    return condicaoNode;
}


-(void)inicializarBotaoAtualizar{
    botaoAtualizar = [[SpriteAtualizarNode alloc] init];
    [botaoAtualizar setSize:botaoIniciarTeste.size];
    [botaoAtualizar setPosition:CGPointMake(botaoIniciarTeste.position.x + 90, botaoIniciarTeste.position.y)];
    [botaoAtualizar setMyDelegate:self];
     
    [self addChild:botaoAtualizar];
}



-(void)inicializarBotaoIniciarAnimacao{
    botaoIniciarTeste = [SKSpriteNode spriteNodeWithImageNamed:@"bt-play.png"];
    [botaoIniciarTeste setSize:CGSizeMake(70, 70)];
    [botaoIniciarTeste setPosition:CGPointMake(580, 530)];
    [botaoIniciarTeste setName:@"iniciarAnimacao"];
    
    [self addChild:botaoIniciarTeste];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint posicao = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:posicao];
    
    if([node.name isEqualToString:@"iniciarAnimacao"]){
        [node removeFromParent];
        [botaoAtualizar setUserInteractionEnabled:NO];
        [self iniciarAnimacaoCondicional];
    }
}


-(void)botaoAtualizarClicado{
    NSString* valor1 = [self gerarValoresAleatorios];
    NSString* valor2 = [self gerarValoresAleatorios];
    NSString* operador = [self gerarOperadoresAleatorios];
    
    for(SpriteCondicaoNode *c in spritesCondicao){
        [c resetarTextura];
        [c resetarValores:valor1 eOperador:operador eValor2:valor2 resultado:valor1];
        
        valor1 = [self gerarValoresAleatorios];
        valor2 = [self gerarValoresAleatorios];
        operador = [self gerarOperadoresAleatorios];
    }
    //[self inicializarParametros];
}


-(void)iniciarAnimacaoCondicional{
    //O CONSOLE INICIA SEM TEXTO
    [console exibeTexto:@""];
    
    //VARRE O VETOR DEFININDO AS TEXTURAS PADROES DE INÍCIO
    for(SpriteCondicaoNode *c in spritesCondicao){
        [c resetarTextura];
    }
    
    //INICIA O TESTE SEMPRE DO PRIMEIRO OBJETO DO VETOR
    [[spritesCondicao objectAtIndex:contadorDeTeste] iniciarTeste];
}


-(void)testeFinalizado:(BOOL)verdadeiro{
   
    //CASO O TESTE NÃO TENHA ENCONTRADO UMA CONDIÇAO VERDADEIRA E AINDA NÃO TENHA CHEGADO AO FIM DO VETOR
    if(!verdadeiro && contadorDeTeste < spritesCondicao.count - 1){
        //É INICIADO O TESTE DO PRÓXIMO OBJETO NO VETOR DE CONDIÇÕES
        [[spritesCondicao objectAtIndex:++contadorDeTeste] iniciarTeste];
    
    }else{
        //CASO TENHA TERMINADO OS TESTES, SE O ULTIMO OBJETO TESTADO SEJA VERDADEIRO
        if ([[spritesCondicao objectAtIndex:contadorDeTeste] retornaVeracidade]) {
            //É INSERIDO NO CONSOLE O TEXTO DO BLOCO DE CÓDIGO DESTA CONDIÇÃO VERDADEIRA
            [console exibeTexto:[[spritesCondicao objectAtIndex:contadorDeTeste] retornaTextoASerExibido]];
        }
        
        //BOTÃO DE INICIAR OS TESTE APARECE NA TELA
        [self addChild:botaoIniciarTeste];
        
        //CONTADOR QUE CONTROLA AS CONDIÇOES TESTADAS É ZERADO
        contadorDeTeste = 0;
        [botaoAtualizar setUserInteractionEnabled:YES];
    }
    
}


@end
