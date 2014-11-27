//
//  SpriteCronometroNode.m
//  DesafioVariavel
//
//  Created by Felipe Costa Nascimento on 9/21/14.
//  Copyright (c) 2014 Felipe Costa Nascimento. All rights reserved.
//

#import "SpriteVisorNode.h"
#import "GerenciadorDesafios.h"

@implementation SpriteVisorNode

-(id)init{
    self = [super initWithImageNamed:@"fundo-visor.png"];
    
    if(self){
        [self setSize:CGSizeMake(245, 245)];
        
        lblValor = [[SKLabelNode alloc] initWithFontNamed:FONT_MEDIUM];
        [lblValor setFontColor:[SKColor blackColor]];
        [lblValor setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter];
        [lblValor setVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter];
        [lblValor setAlpha:0];
        [self addChild:lblValor];
        
        gerador = [[Gerador alloc] init];
        [self inicializarSpritesVisor];
        
    }
    
    return self;
}

-(void)inicializarSpritesVisor{
    acaoCorreto = [self gerarActionComSpritesDeNome:@"animation_correct-" quantidade:14];
    [acaoCorreto setTimingMode:SKActionTimingEaseIn];
    acaoErrado = [self gerarActionComSpritesDeNome:@"animation_wrong-" quantidade:14];
    [acaoErrado setTimingMode:SKActionTimingEaseOut];
}

-(SKAction*)gerarActionComSpritesDeNome:(NSString*)nomeImagem quantidade:(int)nSprites{
    NSMutableArray *vtSprites = [[NSMutableArray alloc] init];
    
    for (int i = 1; i <= nSprites; i++) {
        SKTexture *textura = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"%@%d.png", nomeImagem, i]];
        [vtSprites addObject:textura];
    }
    
    
    return [SKAction animateWithTextures:vtSprites timePerFrame:0.04];
}

-(void)ajustarValorSize{
    [lblValor setFontSize:self.size.width / lblValor.frame.size.width + 30];
}

-(void)setSize:(CGSize)size{
    [super setSize:size];
    [self ajustarValorSize];
}


-(void)gerarValorAleatorioEntreOsTipos:(NSMutableArray*)tipos{
    //EM ALGUNS CASOS O VETOR PODE VIM NULL, NESSES CASOS O MÉTODO APENAS RETORNA
    if (!tipos) {
        NSLog(@"tipos == null");
        return;
    }
    
    //SORTEA UM INDEX COM BASE NO VETOR DE TIPOS PASSADO PELO MÉTODO
    int index = arc4random() % [tipos count];
    
    //GUARDA QUAL O TIPO FOI SORTEADO PARA MAIS TARDE COMPARAR COM A RESPOSTA
    respostaAtual = [tipos objectAtIndex:index];
    
    //DEFINE O VALOR DO TEXTO QUE APARECERÁ NO VISOR
    [lblValor setText:[self gerarValorDoTipo:[tipos objectAtIndex:index]]];
    
    //AJUSTA O ENQUADRAMENTO DO TEXTO NO OBJETO VISOR
    [self ajustarValorSize];
    
    [self esconderValorDaTela:NO];
}

-(NSString*)gerarValorDoTipo:(NSString*)tipo{

    return [gerador retornaValorAleatorioDoTipo:tipo];
}


-(void)esconderValorDaTela:(BOOL)resposta{

    if (resposta) {
        //ANIMAÇÃO FAZ COM QUE O TEXTO DESAPAREÇA
        [lblValor runAction:[SKAction fadeOutWithDuration:0.4]];

    }else{
        //ANIMAÇÃO FAZ COM QUE O TEXTO APAREÇA
        [lblValor runAction:[SKAction fadeInWithDuration:0.2]];
    }
}


-(BOOL)validarResposta:(NSString*)tipo{
    if ([tipo isEqualToString:respostaAtual]) {
        [self executarAnimacaoDeResposta:acaoCorreto resultado:YES];
        return YES;
        
    }else{
        [self executarAnimacaoDeResposta:acaoErrado resultado:NO];
        return NO;
    }
    
}

-(void)executarAnimacaoDeResposta:(SKAction*)action resultado:(BOOL)resposta{
    [lblValor setFontColor:[SKColor whiteColor]];
    SKAction *actionReversa = [action reversedAction];
    
    [self runAction:action completion:^{
        [self runAction:[SKAction waitForDuration:0.8] completion:^{
            [self enviarMensagemAoDelegate:resposta];
            
            [self runAction:actionReversa completion:^{
                [self removeAllActions];
                [lblValor setFontColor:[SKColor blackColor]];
            }];
        }];
    }];
}


-(void)enviarMensagemAoDelegate:(BOOL)resposta{
    if (resposta) {
        [[self myDelegate] respostaCorretaFinalizado];
    
    }else{
        [[self myDelegate] respostaErradaFinalizado];
    }
}

@end
