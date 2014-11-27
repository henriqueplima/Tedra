//
//  BotaoDesafiosNode.h
//  ProjetoFinal
//
//  Created by RAFAEL APARECIDO DE FREITAS on 18/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#include "GerenciadorDesafios.h"

@interface BotaoDesafiosNode : SKSpriteNode

{
    SKLabelNode *valor;
}


-(void)setValor:(NSString*)texto;
-(NSString*)text;


@end
