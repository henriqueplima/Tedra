//
//  SpriteEsteiraNode.h
//  DesafioVariavel
//
//  Created by Felipe Costa Nascimento on 9/21/14.
//  Copyright (c) 2014 Felipe Costa Nascimento. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SpriteCaixinhaNode.h"

@protocol SpriteEsteiraDelegate <NSObject>
-(void)spriteEsteiraLevantado:(BOOL)resultado tiposVariavelGerados:(NSMutableArray*)tipos;
-(void)caixaFoiClicada;
-(BOOL)respostaSelecionada:(NSString*)tipo;
-(void)caixasPosicionadasParaDesafio;
-(void)rodadaAtualTerminou;
-(void)animacaoEsteiraDeEntradaFinalizado;
@end


@interface SpriteEsteiraNode : SKNode <SpriteCaixinhaDelegate>
{
    SKSpriteNode *nodeEsteira;
    SKSpriteNode *nodePistao;
    
    NSMutableArray *vtCaixas;
    NSMutableArray *vtTiposVariavel;

    BOOL esteiraLevantada, ultimoResultado;
}

@property id <SpriteEsteiraDelegate> myDelegate;

-(void)iniciarAnimacaoDesafio;
-(void)iniciarAnimacaoFimDaRodada;
-(void)iniciarAnimacaoMoverEsteira;
-(void)posicionarCaixasParaDesafio;
-(void)habilitarToqueNasCaixas:(BOOL)resultado;
-(void)modificarTipoDasCaixas;
-(void)iniciarAnimacaoDeEntrada;
@end
