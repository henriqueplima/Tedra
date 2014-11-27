//
//  AnimaVariavel.h
//  ProjetoFinal
//
//  Created by Felipe Costa Nascimento on 04/07/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//


#import <SpriteKit/SpriteKit.h>
#import "Gerador.h"
#import "Animacao.h"
#import "SpriteCaixaNode.h"

@interface AnimaVariavel : Animacao //<SpriteCaixaNodeDelegate>
{
    CGSize tamanhoCaixa;
    int enderecoCaixa;
}

-(id)initWithVariavelDoTipo:(NSString*)tipoVariavel;

@end
