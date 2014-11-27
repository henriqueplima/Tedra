//
//  SpriteCronometroNode.h
//  DesafioVariavel
//
//  Created by Felipe Costa Nascimento on 9/21/14.
//  Copyright (c) 2014 Felipe Costa Nascimento. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Gerador.h"


@protocol SpriteVisorDelegate <NSObject>
-(void)respostaCorretaFinalizado;
-(void)respostaErradaFinalizado;
@end



@interface SpriteVisorNode : SKSpriteNode
{
    SKLabelNode *lblValor;
    NSString *respostaAtual;
    SKAction *acaoCorreto;
    SKAction *acaoErrado;
    
    Gerador *gerador;
}

@property id <SpriteVisorDelegate> myDelegate;

-(void)gerarValorAleatorioEntreOsTipos:(NSMutableArray*)tipos;
-(BOOL)validarResposta:(NSString*)tipo;
-(void)esconderValorDaTela:(BOOL)resposta;

@end
