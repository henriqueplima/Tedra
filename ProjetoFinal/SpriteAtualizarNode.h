//
//  SpriteAtualizarNode.h
//  ProjetoFinal
//
//  Created by Felipe Costa Nascimento on 10/08/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

//A CLASSE QUE IMPLEMENTA ESTE PROTOCOLO É AVISADA QUANDO O BOTAO DE ATUALIZAR FOR CLICADO
@protocol SpriteAtualizarNodeDelegate <NSObject>
-(void)botaoAtualizarClicado;
@end


@interface SpriteAtualizarNode : SKSpriteNode
{
    SKSpriteNode *simboloAtualizar;
    SKAction *somAtualizar;
}
@property id <SpriteAtualizarNodeDelegate> myDelegate;



@end
