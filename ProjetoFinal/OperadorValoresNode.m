//
//  SpriteOperadorValores.m
//  testeSprite
//
//  Created by Felipe Costa Nascimento on 18/07/14.
//  Copyright (c) 2014 Felipe Costa Nascimento. All rights reserved.
//

#import "OperadorValoresNode.h"

static const int NUM_TEXTURAS = 11;

@implementation OperadorValoresNode


-(id)initWithValor1:(NSString*)valor1 valor2:(NSString*)valor2{
    self = [super init];
    
    if(self){
        [self inicializaClasse:valor1 :valor2];
    }
    
    return self;
}

-(id)init{
    
    self = [super init];
    
    if(self){
        [self inicializaClasse:@"" :@""];
    }
    
    return self;
}


//METODO QUE CHAMA TODOS OS METODOS QUE INICIALIZAM O NECESSÁRIO
-(void)inicializaClasse:(NSString*)valor1 :(NSString*)valor2{
    [self setTexture:[SKTexture textureWithImageNamed:[NSString stringWithFormat:@"parte-valores%d.png", NUM_TEXTURAS]]];
    [self setName:@"valores"];
    [self setSize:CGSizeMake(300, 75)];
    [self setPosition:CGPointMake(0, 60)];
    [self inicializaLabelsValores:valor1 :valor2];
    [self inicializaAnimacaoExpandir];
    [self inicializaAnimacaoDiminuir];
    
    
    estaVisivel = NO;
}


-(void)inicializaLabelsValores:(NSString*)valor1 :(NSString*)valor2{
    //CRIA A LABEL QUE FICA À ESQUERDA DO SPRITE
    lblValor1 = [SKLabelNode labelNodeWithFontNamed:@"Avenir Next Condensed Medium"];
    [lblValor1 setText:valor1];
    [lblValor1 setFontSize:23];
    [lblValor1 setFontColor:[SKColor blackColor]];
    //[lblValor1 setPosition:CGPointMake(-10, 0)];
    [lblValor1 setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter];
    [lblValor1 setVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter];
    //[lblValor1 setZPosition:5];

    
    //CRIA A LABEL QUE FICA À DIREITA DO SPRITE
    lblValor2 = [SKLabelNode labelNodeWithFontNamed:@"Avenir Next Condensed Medium"];
    [lblValor2 setText:valor2];
    [lblValor2 setFontSize:23];
    [lblValor2 setFontColor:[SKColor blackColor]];
    [lblValor2 setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter];
    [lblValor2 setVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter];
    //[lblValor2 setZPosition:5];
    
    [self ajustarPosicionamentoLabels];
    
    [self addChild:lblValor1];
    [self addChild:lblValor2];
}


-(void)inicializaAnimacaoExpandir{
    //CRIO TEXTURAS PARA TODAS OS SPRITES DA PARTE DE VALORES EM ORDEM INVERSA (PARTE VALORES DIMINUINDO)
    NSMutableArray *vetorTexturas = [[NSMutableArray alloc] init];
    
    for(int i=NUM_TEXTURAS; i>=1; i--){
        //OS SPRITES ESTÃO NUMERADOS, PORTANTO O CONTADOR DO LAÇO É UTILIZADO PARA GERAR TODOS OS SPRITES
        SKTexture *textura = [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"parte-valores%d.png", i]];
        
        [vetorTexturas addObject:textura];
    }
    
    animacaoExpandir = [SKAction animateWithTextures:vetorTexturas timePerFrame:0.04];
}


-(void)inicializaAnimacaoDiminuir{
    //CRIO UMA ANIMAÇAO REVERSA À DE EXPANDIR
    animacaoDiminuir = [animacaoExpandir reversedAction];
}



-(void)iniciarAnimacao{
    int distancia = self.size.width * 0.3;
    
    //VERIFICA SE O SPRITE ESTÁ VISIVEL NA TELA
    if(estaVisivel){
        
        //CRIA UMA ANIMAÇÃO DE MOVER QUE FARÁ A LABEL IR PARA A POSIÇÃO CORRETA
        SKAction *moverParaDireita = [SKAction moveToX:lblValor1.position.x + distancia duration:animacaoExpandir.duration];
        SKAction *moverParaEsquerda = [SKAction moveToX:lblValor2.position.x - distancia duration:animacaoExpandir.duration];
        
        //AS LABELS EXECUTAM SUA RESPECTIVA ANIMAÇÃO
        [lblValor1 runAction:moverParaDireita];
        [lblValor2 runAction:moverParaEsquerda completion:^{
            [lblValor1 removeAllActions];
            [lblValor2 removeAllActions];
            estaVisivel = NO;
        }];
        
    }else{
        //CRIA UMA ANIMAÇÃO DE MOVER QUE FARÁ A LABEL IR PARA A POSIÇÃO CORRETA
        SKAction *moverParaDireita = [SKAction moveToX:lblValor1.position.x - distancia duration:animacaoExpandir.duration];
        SKAction *moverParaEsquerda = [SKAction moveToX:lblValor2.position.x + distancia duration:animacaoExpandir.duration];
        
        //AS LABELS EXECUTAM SUA RESPECTIVA ANIMAÇÃO
        [lblValor1 runAction:moverParaDireita];
        [lblValor2 runAction:moverParaEsquerda completion:^{
            [lblValor1 removeAllActions];
            [lblValor2 removeAllActions];
            estaVisivel = YES;
        }];
    }
}

-(void)ajustarPosicionamentoLabels{
    [lblValor1 setPosition:CGPointMake(self.size.width * -0.02, 0)];
    [lblValor2 setPosition:CGPointMake(self.size.width * 0.02, 0)];
}

-(SKAction*)getAnimacaoExpandir{
    return animacaoExpandir;
}


-(SKAction*)getAnimacaoDiminuir{
    return animacaoDiminuir;
}

-(void)setLabelValor1:(NSString*)valor1{
    [lblValor1 setText:valor1];
}

-(void)setLabelValor2:(NSString*)valor2{
    [lblValor2 setText:valor2];
}

-(NSString*)getValor1{
    return [lblValor1 text];
}

-(NSString*)getValor2{
    return [lblValor2 text];
}



@end
