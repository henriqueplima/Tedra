//
//  SpriteCronometroNode.h
//  DesafioVariavel
//
//  Created by Felipe Costa Nascimento on 9/23/14.
//  Copyright (c) 2014 -(float)getTempoMedioDeRespostaFelipe Costa Nascimento. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol SpriteCronometroDelegate <NSObject>
-(void)tempoEsgotado;
-(void)animacaoDeEntradaCronometroFinalizada;
@end


@interface SpriteCronometroNode : SKSpriteNode
{
    int widthSize, nAcertos, nErros;
    float tempoDuracaoInicial ,tempoDuracaoAtual, prograssaoTempoDinamica;
    SKAction *acaoIniciarContagem;
    NSMutableArray *vtTempoDeResposta;
}

@property id<SpriteCronometroDelegate> myDelegate;
@property float progressaoTempo;

-(id)initWithTempoTotalEmSegundos:(float)tempo progressaoDeTempo:(float)progressao;
-(id)initWithTempoTotalEmSegundos:(float)tempo;
-(void)iniciarContagem;
-(void)prepararCronometro;
-(void)prepararCronometroComNovoTempo:(float)tempo;
-(void)pararContagem;
-(void)iniciarAnimacaoDeEntrada;
-(void)usuarioErrouResposta;
-(void)usuarioAcertouResposta;
-(NSArray*)getVetorTempos;
-(void)resetarDados;

@end
