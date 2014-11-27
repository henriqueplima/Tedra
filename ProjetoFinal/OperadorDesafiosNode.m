//
//  OperadorDesafiosNode.m
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 24/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "OperadorDesafiosNode.h"
//#include "GerenciadorDesafios.h"

@implementation OperadorDesafiosNode

-(id)initWithImageNamed:(NSString *)name{
    
    self = [super initWithImageNamed:name];
    if (self) {
        valor = [[SKLabelNode alloc] initWithFontNamed:FONT_LIGHT];
        valor.fontSize = self.size.width / valor.frame.size.width + 20;
        [valor setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter];
        [valor setVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter];
        [self addChild:valor];
        [self setSize:CGSizeMake(156.0, 156.0)];
        [valor setFontColor:[UIColor colorWithRed:(76.0/255.0) green:(95.0/255.0) blue:(138.0/255.0) alpha:1]];
        [self setValor:@"?"];
        [self inicializarSprites];
    }
    return self;
}

-(void)setValor:(NSString *)texto{
    [valor setText:texto];
    //valor.fontSize = self.size.width / valor.frame.size.width + 20;
    valor.fontSize = 90.0;
}

-(NSString*)getValor{
    return valor.text;
}


-(SKAction*)gerarActionComSpritesDeNome:(NSString*)nomeImagem quantidade:(int)nSprites{
    NSMutableArray *vtSprites = [[NSMutableArray alloc] init];
    
    for (int i = 1; i <= nSprites; i++) {
        SKTexture *textura = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"%@%d.png", nomeImagem, i]];
        [vtSprites addObject:textura];
    }
    
    
    return [SKAction animateWithTextures:vtSprites timePerFrame:0.04];
}

-(void)acertou{
    atual = acaoCorreto;
    [self executarAnimacaoDeResposta];
}

-(void)errou{
    atual = acaoErrado;
    [self executarAnimacaoDeResposta];
    
}

-(void)inicializarSprites{
    acaoCorreto = [self gerarActionComSpritesDeNome:@"animation_correct-" quantidade:14];
    [acaoCorreto setTimingMode:SKActionTimingEaseIn];
    acaoErrado = [self gerarActionComSpritesDeNome:@"animation_wrong-" quantidade:14];
    [acaoErrado setTimingMode:SKActionTimingEaseOut];
}

-(SKAction*)acaoReversa{
    acaoReversa = [atual reversedAction];
    [valor setFontColor:[UIColor colorWithRed:(76.0/255.0) green:(95.0/255.0) blue:(138.0/255.0) alpha:1]];
    return acaoReversa;
}
-(void)executarAnimacaoDeResposta{
    
    [valor setFontColor:[SKColor whiteColor]];
    [self runAction:atual];
    
}



@end
