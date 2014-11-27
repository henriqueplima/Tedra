//
//  SaidaDeDados.m
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 07/08/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "SaidaDeDados.h"

@implementation SaidaDeDados

-(id)init{
    if (self = [super init]) {
        textoExibido = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        //[textoExibido setText:@">"];
        [textoExibido setFontSize:18];
        [textoExibido setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
        [textoExibido setPosition:CGPointMake(-150, 0)];
        [textoExibido setFontColor:[UIColor blackColor]];
        SKTexture *textura = [SKTexture textureWithImageNamed:@"saida-texto.png"];
        [self setTexture:textura];
        [self setSize:CGSizeMake(346, 158)];
        [self addChild:textoExibido];
        
    }
    return self;
}


-(void)exibeTexto:(NSString*)texto{
    [textoExibido setText:[NSString stringWithFormat:@"%@",texto]];
}
@end
