//
//  SaidaDeDados.h
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 07/08/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SaidaDeDados : SKSpriteNode
{
    SKLabelNode *textoExibido;
}

-(void)exibeTexto:(NSString*)texto;

@end
