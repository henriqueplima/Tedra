//
//  AnimaOperadores.m
//  ProjetoFinal
//
//  Created by Felipe Costa Nascimento on 08/07/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "AnimaOperadores.h"

@implementation AnimaOperadores

-(id)initWithOperador:(NSString*)tipoOperador{
    if (self = [super init]) {
        /* Setup your scene here */
        tipoOperadorAtual = tipoOperador;
        spritesOperador = [[NSMutableArray alloc] init];
        
        //ADICIONA UM OPERADOR NO CANTO SUPERIOR ESQUERDO DA TELA
        CGPoint position = CGPointMake(190, 400);
        [self criarOperador:position];
        
        //ADICIONA UM OPERADOR NO CANTO INFERIOR ESQUERDO DA TELA
        position = CGPointMake(190, 100);
        [self criarOperador:position];
        
        //ADICIONA UM OPERADOR NO CANTO SUPERIOR DIREITO DA TELA
        position = CGPointMake(580, 400);
        [self criarOperador: position];
        
        //ADICIONA UM OPERADOR NO CANTO INFERIOR DIREITO DA TELA
        position = CGPointMake(580, 100);
        [self criarOperador:position];
        
        //CRIA A LABEL QUE EXIBE O TIPO DE OPERADOR ATUAL
        [self inicializarLabelTipoOperador];
        
        //GERA VALORES ALEATORIOS PARA OS SPRITES
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            
            [self atualizarValoresDoTipo:tipoOperador];
        });
    
        
        //CRIA A LABEL QUE ATUALIZA OS VALORES DOS SPRITES
        [self criarLabelAtualizar];
        
        [self setBackgroundColor:[UIColor whiteColor]];
    }
    return self;

}


-(void)criarOperador:(CGPoint)posicao{
    SpriteOperadorNode *spriteOperador = [[SpriteOperadorNode alloc] init];
    [spriteOperador setPosition:posicao];
    
    [spritesOperador addObject:spriteOperador];
    
    [self addChild:spriteOperador];
}


-(void)criarLabelAtualizar{
    SpriteAtualizarNode *spriteAtualizar = [[SpriteAtualizarNode alloc] init];
    [spriteAtualizar setPosition:CGPointMake(384, 300)];
    [spriteAtualizar setMyDelegate:self];
    
    [self addChild:spriteAtualizar];

}


-(void)botaoAtualizarClicado{
    [self atualizarValoresDoTipo:tipoOperadorAtual];
}


-(void)atualizarValoresDoTipo:(NSString*)tipoOperador{
    Calculador *calculadora = [[Calculador alloc] init];
    Gerador *geradorValores = [[Gerador alloc] init];
    
    
    NSString *valor1, *operador, *valor2, *resultado;
    
    for(SpriteOperadorNode *node in spritesOperador){

        valor1 = [geradorValores retornaValorAleatorioParaOperador:tipoOperador];
        operador = [geradorValores retornaOperadorDoTipo:tipoOperador];
        valor2 = [geradorValores retornaValorAleatorioParaOperador:tipoOperador];
        resultado = [calculadora calculaOperador:operador numero1:valor1 numero2:valor2];

        //DEFINE OS NOVOS VALORES PARA O SPRITE DESSE INDEX
        [node setLabelValor1:valor1 operador:operador valor2:valor2 resultado:resultado];
    }
}


-(void)inicializarLabelTipoOperador{
    lblTipoOperador = [[SKLabelNode alloc] initWithFontNamed:@"Lucida Grande"];
    [lblTipoOperador setText:[NSString stringWithFormat:@"Operador %@", tipoOperadorAtual]];
    [lblTipoOperador setFontSize:25];
    [lblTipoOperador setFontColor:[SKColor blackColor]];
    [lblTipoOperador setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    [lblTipoOperador setPosition:CGPointMake(10, 560)];
    
    [self addChild:lblTipoOperador];
}

@end
