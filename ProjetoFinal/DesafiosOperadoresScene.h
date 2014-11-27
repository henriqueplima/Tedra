//
//  DesafiosOperadoresScene.h
//  ProjetoFinal
//
//  Created by RAFAEL APARECIDO DE FREITAS on 18/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//



#import <SpriteKit/SpriteKit.h>
#import "BotaoDesafiosNode.h"
#import "Gerador.h"
#import "GerenciadorDesafios.h"
#import "OperadorDesafiosNode.h"
#import "ProgressoDesafioBar.h"

@interface DesafiosOperadoresScene : DesafioScene

{
    SKLabelNode *lblParte1, *lblParte2, *lblResultado, *lblIgual, *lblNAcertos, *lblNErros;
    
    SKSpriteNode *fundo;
    
    ProgressoDesafioBar *progresso;
    DesafioOperadores *desafioAtual;
    Gerador *gerador;
    
}
@end
