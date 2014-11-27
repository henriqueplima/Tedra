//
//  AnimaCondSimples.h
//  ProjetoFinal
//
//  Created by Felipe Costa Nascimento on 26/07/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Animacao.h"
#import "SpriteAtualizarNode.h"
#import "SpriteCondicaoNode.h"
#import "Gerador.h"
#import "SaidaDeDados.h"

@interface AnimaCondSimples : Animacao <SpriteCondicaoNodeDelegate, SpriteAtualizarNodeDelegate>
{
    NSMutableArray *spritesCondicao;
    SpriteAtualizarNode *botaoAtualizar;
    SKSpriteNode *botaoIniciarTeste;
    int contadorDeTeste;
    SaidaDeDados *console;

}


-(id)initWithCondicao:(NSString*)condicao;
@end
