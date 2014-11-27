//
//  OperadorDesafiosNode.h
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 24/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GerenciadorDesafios.h"

@interface OperadorDesafiosNode : SKSpriteNode
{
    SKLabelNode *valor;
    SKAction *acaoCorreto;
    SKAction *acaoErrado;
    SKAction *atual;
    SKAction *acaoReversa;
}


-(void)setValor:(NSString*)texto;
-(NSString*)getValor;
-(void)acertou;
-(void)errou;
-(SKAction*)acaoReversa;

@end
