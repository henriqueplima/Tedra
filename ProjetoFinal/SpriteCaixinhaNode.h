//
//  SpriteCaixaNode.h
//  DesafioVariavel
//
//  Created by Felipe Costa Nascimento on 9/21/14.
//  Copyright (c) 2014 Felipe Costa Nascimento. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>


@protocol SpriteCaixinhaDelegate <NSObject>
-(void)caixaFoiClicada;
-(BOOL)caixaClicadaDoTipo:(NSString*)tipo;
-(void)animacaoMoverCaixaFinalizado:(BOOL)fimDesafio;
@end


@interface SpriteCaixinhaNode : SKSpriteNode
{
    SKLabelNode *lblTipo;
    int meuIndex, nAcertos, nErros;
    float progressaoDuracaoDinamica, duracaoAtual;
    NSString *minhaCor;

    SKAction *acaoMoverX;
    SKAction *acaoPular;
    SKAction *acaoEncherCaixa;
}

@property id <SpriteCaixinhaDelegate> myDelegate;
@property float progressaoDuracao;

-(void)setTipo:(NSString*)tipo;
-(id)initWithTipoVariavel:(NSString*)tipo indexPosição:(int)posicao progressaoDuracao:(float)progressao;
-(void)iniciarAnimacaoMoverCaixaPara:(int)posicaoFinal fimDesafio:(BOOL)resposta;
-(NSString*)getTipo;
-(void)resetarTextura;
-(void)diminuirAnimacaoDuracao;
-(void)aumentarDuracaoAnimacao;
@end
