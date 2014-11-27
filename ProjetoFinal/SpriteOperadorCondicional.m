//
//  SpriteTipoNode.m
//  ProjetoFinal
//
//  Created by RAFAEL APARECIDO DE FREITAS on 06/08/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "SpriteOperadorCondicional.h"

@implementation SpriteOperadorCondicional

-(id)initWithResultado:(NSString*)resultado{
    self = [super init];
    
    if(self){
        [self inicializaSpriteResultado:resultado];
        textoASerExibido = resultado;
        verdadeiro = YES;
    }
    
    return self;
}

-(id)initWithValores:(NSString*)valor1 operador:(NSString*)operador valor2:(NSString*)valor2 resultado:(NSString*)resultado{
    self = [super init];
    
    if(self){
        [self inicializaSpriteResultado:resultado];
        textoASerExibido = resultado;
        [self inicializaSpriteValores:valor1 valor2:valor2];
        [self inicializaSpriteOperador:operador];
        [self verificaSeEVerdadeiro:valor1 eOperador:operador eValor2:valor2];
    }
    return self;
}

//CRIAR O SPRITE ONDE EXIBE O BLOCO DE TEXTO 
-(void)inicializaSpriteResultado:(NSString*)resultado{
    
    spriteResultado = [[OperadorResultadoNode alloc] initWithResultado:resultado];
    [spriteResultado setTexture:[SKTexture textureWithImageNamed:@"parte-resultado.png"]];
    [spriteResultado  setPosition:CGPointMake(0, -40)];
    [spriteResultado setSize:CGSizeMake(227, 159)];
    [spriteResultado iniciarAnimacao];
    [spriteResultado setLabelResultado:[NSString stringWithFormat:@"escreva (\"%@\")",resultado]];
    [[spriteResultado lblResultado] setFontSize:20];
    [[spriteResultado lblResultado] setFontColor:[SKColor blackColor]];

    [self addChild:spriteResultado];
}


//CRIA O SPRITE QUE EXIBE OS VALORES QUE SERAM VERIFICADOS NA CONDIÇÃO
-(void)inicializaSpriteValores:(NSString*)valor1 valor2:(NSString*)valor2{
    spriteValores = [[OperadorValoresNode alloc] initWithValor1:valor1 valor2:valor2];
    [spriteValores setTexture:[SKTexture textureWithImageNamed:@"parte-valores1.png"]];
    [spriteValores iniciarAnimacao];
    [spriteResultado addChild:spriteValores];
}


//CRIA O SPRITE QUE MOSTRA O OPERADOR DOS VALORES
-(void)inicializaSpriteOperador:(NSString*)operador{
    spriteOperador = [[OperadorNode alloc] initWithOperador:operador];
    
    [spriteValores addChild:spriteOperador];
}


-(void)iniciarAnimacao{
    [spriteValores setTexture:[SKTexture textureWithImageNamed:@"parte-valores1"]];

    SKAction *piscaEsquerda = [self criarAnimacaoPiscarComTextura:@"valor1-amarelo.png"];
    SKAction *piscaDireita = [self criarAnimacaoPiscarComTextura:@"valor2-amarelo.png"];
    
    
    
    //O PRIMEIRO BLOCO INICIA A ANIMAÇÃO DO LADOR ESQUERDO POR 4 VEZES
    [spriteValores runAction:[SKAction repeatAction:piscaEsquerda count:4] completion:^{
        //O SEGUNDO BLOCO INICIA A ANIMAÇÃO DO LADOR DIREITO POR 4 VEZES
        [spriteValores runAction:[SKAction repeatAction:piscaDireita count:4] completion:^{
            [spriteValores removeAllActions];
            
            //VERIFICA SE A CONDIÇÃO É VERDADEIRA PARA QUE SEJA COLOCADA A TEXTURA QUE INDICA QUE É VERDADEIRO
            if(verdadeiro){
                [spriteValores setTexture:[SKTexture textureWithImageNamed:@"valores-verdadeiro.png"]];
                [self runAction:[SKAction playSoundFileNamed:@"correto.aiff" waitForCompletion:NO]];
            
            }else{
                [spriteValores setTexture:[SKTexture textureWithImageNamed:@"valores-errado.png"]];
            }
            
            //AVISA PARA O DELEGATE QUE A VERIFICAÇÃO FOI FINALIZADA
            [[self myDelegate] testeFinalizado];
            
        }];
    }];
}


-(void)resetarTextura{
    if(spriteValores){
        [spriteValores setTexture:[SKTexture textureWithImageNamed:@"parte-valores1.png"]];
    }
    
}


-(SKAction*)criarAnimacaoPiscarComTextura:(NSString*)nomeTextura{
    //CRIA UM VETOR COM OS SPRITES DE "VERIFICAÇÃO" DOS VALORES, LOGO APÓS É RETORNADA A ANIMAÇÃO DESTE VETOR
    NSArray *texturas = [NSArray arrayWithObjects:[SKTexture textureWithImageNamed:nomeTextura], spriteValores.texture, nil];
    
    return [SKAction animateWithTextures:texturas timePerFrame:0.3];
}


-(void)verificaSeEVerdadeiro:(NSString*)valor1 eOperador:(NSString*)operador eValor2:(NSString*)valor2{
    Calculador *calculador = [[Calculador alloc] init];
    NSString *resultado = [calculador calculaOperador:operador numero1:valor1 numero2:valor2];
    
    if ([resultado isEqualToString:@"Verdadeiro"]) {
        verdadeiro = YES;
    }else{
        verdadeiro = NO;
    }
}

-(BOOL)retornaVeracidade{
    return verdadeiro;
}


-(void)ajustarTamanho:(int)widthBase{
    //VERIFICA SE É UMA CONDIÇÃO COMPLETA (CONTÉM VALOR1, VALOR2 E OPERADOR OU É APENAS A PARTE DO RESULTADO)
    if(spriteValores){
        //ESTE METODO RECEBE O TAMANHO DO PAI DESTE NODE E AJUSTA OS TAMANHOS DOS NODES DESTA CLASSE
        [self definirNovoTamanho:spriteValores widthBase:widthBase novoWidth:2.2 novoHeight:0.5];
        [self definirNovoTamanho:spriteOperador widthBase:widthBase novoWidth:0.8 novoHeight:0.8];
        [self definirNovoTamanho:spriteResultado widthBase:widthBase novoWidth:1.6 novoHeight:1.1];
        
        [spriteValores ajustarPosicionamentoLabels];
        [spriteValores iniciarAnimacao];
    
    }else{
        [self definirNovoTamanho:spriteResultado widthBase:widthBase novoWidth:1 novoHeight:0.7];
    }
    
}


-(void)definirNovoTamanho:(SKSpriteNode*)node widthBase:(int)widthBase novoWidth:(float)novoWidth novoHeight:(float)novoHeight{
    
    [node setSize:CGSizeMake(widthBase * novoWidth, widthBase * novoHeight)];
}


-(NSString*)retornaTextoASerExibido{
    return textoASerExibido;
}

@end
