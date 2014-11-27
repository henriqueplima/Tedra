//
//  SpriteCaixaNode.m
//  DesafioVariavel
//
//  Created by Felipe Costa Nascimento on 9/21/14.
//  Copyright (c) 2014 Felipe Costa Nascimento. All rights reserved.
//

#import "SpriteCaixinhaNode.h"
#import "GerenciadorDesafios.h"

static const int GREEN = 1;
static const int RED = 2;
static const int YELLOW = 3;

@implementation SpriteCaixinhaNode

-(id)initWithTipoVariavel:(NSString*)tipo indexPosição:(int)posicao progressaoDuracao:(float)progressao{
    self = [super initWithImageNamed:[NSString stringWithFormat:@"caixa%d-vazia.png", posicao]];
    
    if(self){
        meuIndex = posicao;
        self.progressaoDuracao = progressao;
        minhaCor = [self retornaMinhaCor:posicao];
        
        lblTipo = [[SKLabelNode alloc] initWithFontNamed:FONT_LIGHT];
        [lblTipo setText:tipo];
        [lblTipo setFontColor:[SKColor blackColor]];
        [lblTipo setFontSize:self.size.width / lblTipo.frame.size.width + 25];
        [lblTipo setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter];
        [lblTipo setVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter];
        [self addChild:lblTipo];
        
        [self inicializarAnimacaoMoverX];
        [self inicializarAnimacaoPular];
        [self inicializarAnimacaoEncherCaixa];
        
        [self setUserInteractionEnabled:NO];
    }
    
    
    return self;
}


-(void)inicializarAnimacaoPular{
    int distancia = 15;
    float duracao = 0.2;
    
    //É CRIADO A ANIMAÇÃO QUE FAZ COM QUE A CAIXA SUBA
    SKAction *subir = [SKAction moveByX:0 y:distancia duration:duracao];
    [subir setTimingMode:SKActionTimingEaseOut];
    
    //É CRIADO A ANIMAÇÃO QUE FAZ COM QUE A CAIXA DESÇA
    SKAction *descer = [SKAction moveByX:0 y:-distancia duration:duracao];
    [descer setTimingMode:SKActionTimingEaseIn];
    
    acaoPular = [SKAction sequence:@[subir, descer]];
}

-(void)inicializarAnimacaoMoverX{
    acaoMoverX = [SKAction moveByX:695 y:0 duration:1.3];
    [acaoMoverX setTimingMode:SKActionTimingEaseOut];
    duracaoAtual = [acaoMoverX duration];
}

-(void)inicializarAnimacaoEncherCaixa{
    int numTexturas = 8;
    NSMutableArray *vtTexturas = [[NSMutableArray alloc] init];
    
    for (int i=1; i <= numTexturas; i++) {
        SKTexture *textura = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"animation_%@_box-%i", minhaCor, i]];
        
        [vtTexturas addObject:textura];
    }
    
    acaoEncherCaixa = [SKAction animateWithTextures:vtTexturas timePerFrame:0.05];
    [acaoEncherCaixa setTimingMode:SKActionTimingEaseOut];
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //ESTA MÉTODO APENAS AVISA QUE UMA CAIXA FOI CLICADA. A CENA FICA ENCARREGADA DE MANDAR O CRONÔMETRO PARAR
    [[self myDelegate] caixaFoiClicada];
    
    [self iniciarAnimacaoToque];
}


-(void)iniciarAnimacaoToque{
    //APÓS A CAIXA SUBIR É EXECUTADO A ANIMAÇÃO PARA DESCER A CAIXA
    [self runAction:acaoPular completion:^{
        
        //AVISA AO DELEGATE QUE A CAIXA QUE FOI CLICADA É A QUE ESTÁ SENDO PASSADA POR PARÂMETRO
        [self iniciarAnimacaoEncherCaixa:[[self myDelegate] caixaClicadaDoTipo:[lblTipo text]]];
    }];
}


-(void)iniciarAnimacaoMoverCaixaPara:(int)posicaoFinal fimDesafio:(BOOL)resposta{
    
    //ESTA CONDIÇÃO É USADA PARA QUE APENAS 1 CAIXA AVISE O DELEGATE QUE A ANIMAÇÃO TERMINOU
    if (meuIndex == 3) {
        [self runAction:acaoMoverX completion:^{
    
            
            [self removeAllActions];
            [[self myDelegate] animacaoMoverCaixaFinalizado:resposta];
        }];
    
    }else{
        [self runAction:acaoMoverX];
    }
    
}


-(void)diminuirAnimacaoDuracao{
    
    duracaoAtual -= self.progressaoDuracao;

    [self definirNovaDuracaoAnimacao:duracaoAtual];
}


-(void)aumentarDuracaoAnimacao{
    
    duracaoAtual += self.progressaoDuracao;
    
    [self definirNovaDuracaoAnimacao:duracaoAtual];
}



-(void)definirNovaDuracaoAnimacao:(float)duracao{
    
    if (duracao < 0.6) {
        duracao = 0.6;
    
    }else if(duracao > 2){
        duracao = 2;
    }
    
    NSLog(@"%f", duracao);
    
    [acaoMoverX setDuration:duracao];
}

-(void)iniciarAnimacaoEncherCaixa:(BOOL)resposta{
    if (resposta) {
        [self runAction:acaoEncherCaixa];
        [lblTipo setFontColor:[UIColor whiteColor]];
    }
}


-(NSString*)getTipo{
    return [lblTipo text];
}

-(void)setTipo:(NSString*)tipo{
    [lblTipo setText:tipo];
}

-(void)resetarTextura{
    [lblTipo setFontColor:[UIColor blackColor]];
    [self setTexture:[SKTexture textureWithImageNamed:[NSString stringWithFormat:@"caixa%d-vazia.png", meuIndex]]];
}

-(NSString*)retornaMinhaCor:(int)index{
    switch (index) {
        case GREEN:
            return @"green";
            
        case RED:
            return @"red";
            
        case YELLOW:
            return @"yellow";
            
        default:
            return @"Erro";
    }
}

@end
