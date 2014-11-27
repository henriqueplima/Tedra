//
//  AnimaVariavel.m
//  ProjetoFinal
//
//  Created by Felipe Costa Nascimento on 04/07/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "AnimaVariavel.h"

@implementation AnimaVariavel

-(id)initWithVariavelDoTipo:(NSString*)tipoVariavel{
    if (self = [super init]) {
        enderecoCaixa = 1;
        tamanhoCaixa = CGSizeMake(250, 267);
        
//        SKSpriteNode *fundo = [[SKSpriteNode alloc] initWithImageNamed:@"fundo-animaVariavel.png"];
//        [fundo setSize:CGSizeMake(661, 470)];
//        [fundo setPosition:CGPointMake(360, 270)];        FUNDO DA ANIMAÇÃO
//        [self addChild:fundo];
        
        Gerador *gerador = [[Gerador alloc] init];
        
        //ADICIONA UMA CAIXA NO CANTO SUPERIOR ESQUERDO DA TELA
        CGPoint position = CGPointMake(210, 490);
        [self criarNovaCaixaComConteudo:gerador tipoVariavel:tipoVariavel posicao:position];
        
        //ADICIONA UMA CAIXA NO CANTO INFERIOR ESQUERDO DA TELA
        position = CGPointMake(210, 210);
        [self runAction:[SKAction waitForDuration:0.8] completion:^{
            [self criarNovaCaixaComConteudo:gerador tipoVariavel:tipoVariavel posicao:position];
        }];
        
        //ADICIONA UMA CAIXA NO CANTO SUPERIOR DIREITO DA TELA
        position = CGPointMake(575, 490);
        [self runAction:[SKAction waitForDuration:0.4] completion:^{
            [self criarNovaCaixaComConteudo:gerador tipoVariavel:tipoVariavel posicao:position];
        }];
        
        //ADICIONA UMA CAIXA NO CANTO INFERIOR DIREITO DA TELA
        position = CGPointMake(575, 210);
        [self runAction:[SKAction waitForDuration:1.2] completion:^{
            [self criarNovaCaixaComConteudo:gerador tipoVariavel:tipoVariavel posicao:position];
        }];
        
        
        [self setBackgroundColor:[UIColor whiteColor]];

    }
    
    return self;
}


//METODO QUE RECEBE OS PARAMETROS NECESSARIOS PARA CRIAR UMA CAIXA E DEFINE O ENDEREÇO AUTOMATICAMENTE
-(void)criarNovaCaixaComConteudo:(Gerador*)gerador tipoVariavel:(NSString*)tipoVariavel posicao:(CGPoint)posicao{
    NSString *tipoVariavelLower = [tipoVariavel lowercaseString];
    
    NSString *nome = [gerador retornaNomeVariavel:tipoVariavelLower];
    NSString *conteudo = [gerador retornaValorVarivel:tipoVariavelLower];
    
    
    SpriteCaixaNode *caixa = [[SpriteCaixaNode alloc] initWithConteudo:conteudo nome:nome tipo:tipoVariavelLower tamanho:tamanhoCaixa];
    [caixa setLabelEndereco:enderecoCaixa++];
    [caixa setPosition:posicao];
    [caixa iniciarAnimacaoIntroducao];
    
    [self addChild:caixa];
    
    
}


-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
