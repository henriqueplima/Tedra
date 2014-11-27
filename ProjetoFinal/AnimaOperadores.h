//
//  AnimaOperadores.h
//  ProjetoFinal
//
//  Created by Felipe Costa Nascimento on 08/07/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Animacao.h"
#import "SpriteAtualizarNode.h"
#import "SpriteOperadorNode.h"
#import "Calculador.h"
#import "Gerador.h"


@interface AnimaOperadores : Animacao <SpriteAtualizarNodeDelegate>
{
    NSMutableArray *spritesOperador;
    NSString *tipoOperadorAtual;
    SKLabelNode *lblTipoOperador;
}


-(id)initWithOperador:(NSString*)tipoOperador;

@end
