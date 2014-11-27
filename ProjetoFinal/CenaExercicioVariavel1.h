//
//  MyScene.h
//  Exercicio
//

//  Copyright (c) 2014 Henrique Pereira de Lima. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SpriteCaixaNode.h"
#import "SpriteLabelNode.h"
#import "Gerador.h"
#import "CenaExercicio.h"


@interface CenaExercicioVariavel1 : CenaExercicio
{
    NSMutableArray *vetorCaixas;
    SpriteLabelNode *conteudoAtivo;
    SKLabelNode *codigo;
}

@property int corretos;

@end
