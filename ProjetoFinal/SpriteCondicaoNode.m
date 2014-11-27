//
//  TipoCondicionalNode.m
//  ProjetoFinal
//
//  Created by Felipe Costa Nascimento on 05/08/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "SpriteCondicaoNode.h"

@implementation SpriteCondicaoNode

-(id)initWithType:(NSString*)tipo{
    self = [super init];
    if (self) {
        tipoCondicao = tipo;
        [self montaSprite:tipo];
        
    }
    return self;
}

-(void)montaSprite:(NSString*)tipo{
    CGSize tamanho;
    
    if ([tipo isEqualToString:@"se"]) {
        tamanho = CGSizeMake(120, 91);
        [self criaSpriteExclamacao];
        
    }else if ([tipo isEqualToString:@"senaoSe"]){
        tamanho = CGSizeMake(120, 204);
        [self criaSpriteExclamacao];
        
    }else{
        tamanho = CGSizeMake(212, 142);
    }
    
    
    [self setTexture:[self getTexturaDoTipo:@"normal"]];
    [self setSize:tamanho];
}

-(void)criaSpriteExclamacao{
    spriteExclamacao = [SKSpriteNode spriteNodeWithImageNamed:@"sprite-exclamacao.png"];
    
    CGPoint posicao;
    
    if ([tipoCondicao isEqualToString:@"se"]) {
        posicao = CGPointMake(-15, 39);
    }else if ([tipoCondicao isEqualToString:@"senaoSe"]){
        posicao = CGPointMake(-15, -17);
    }

    
    [spriteExclamacao setPosition:posicao];
    [spriteExclamacao setSize:CGSizeMake(17, 43)];
}


//ESTE METODO RETORNA UMA TEXTURA COM BASE DO TIPO DE CONDIÇAO DESTA CLASSE E TIPO DE TEXTURA (NORMAL OU VERDE)
-(SKTexture*)getTexturaDoTipo:(NSString*)tipoTextura{
    return [SKTexture textureWithImageNamed:[NSString stringWithFormat:@"%@-%@.png", tipoCondicao, tipoTextura]];
}


-(void)mostraExclamacao:(BOOL)status{
    
    // Só adiciona exclamação caso o tipo seja diferente de "senao"
    if (![self isSenao]) {
        if (status) {
            [self addChild:spriteExclamacao];
        }else{
            [spriteExclamacao removeFromParent];
        }
    }
   

}
-(NSString*)getTipo{
    return tipoCondicao;
}


-(void)criarValores:(NSString*)valor1 eOperador:(NSString*)operador eValor2:(NSString*)valor2 resultado:(NSString*)resultado{

    CGPoint posicao;
    
    if ([tipoCondicao isEqualToString:@"se"]) {
        posicao = CGPointMake(140, -20);
        [self inicializarSpriteOperador:valor1 eOperador:operador eValor2:valor2 resultado:resultado posicao:posicao];
        
    }else if ([tipoCondicao isEqualToString:@"senaoSe"]){
        posicao = CGPointMake(140, -75);
        [self inicializarSpriteOperador:valor1 eOperador:operador eValor2:valor2 resultado:resultado posicao:posicao];
        
    }else{
        posicao = CGPointMake(0, -80);
        [self inicializarSpriteOperadorResultado:resultado posicao:posicao];
        
    }
    
}

-(void)inicializarSpriteOperador:(NSString*)valor1 eOperador:(NSString*)operador eValor2:(NSString*)valor2 resultado:(NSString*)resultado posicao:(CGPoint)posicao{
    spriteOperador = [[SpriteOperadorCondicional alloc] initWithValores:valor1 operador:operador valor2:valor2 resultado:resultado];
    [spriteOperador ajustarTamanho:self.size.width];
    spriteOperador.myDelegate = self;
    [spriteOperador setPosition:posicao];
    
    [self addChild:spriteOperador];
}

-(void)inicializarSpriteOperadorResultado:(NSString*)resultado posicao:(CGPoint)posicao{
    spriteOperador = [[SpriteOperadorCondicional alloc] initWithResultado:resultado];
    [spriteOperador ajustarTamanho:self.size.width];
    [spriteOperador setPosition:posicao];
    
    [self addChild:spriteOperador];
}


-(void)resetarTextura{
    if([self isSenao]){
        [self setTexture:[self getTexturaDoTipo:@"normal"]];
        return;
    }
    
    [spriteOperador resetarTextura];
}


-(void)iniciarTeste{
    //ANTES DE INICIAR O TESTE É VERIFICADO SE A CONDIÇÃO É UM SENÃO, CASO SEJA A TEXTURA, E MODIFICADA E FIM DE MÉTODO
    if([self isSenao]){
        [self setTexture:[self getTexturaDoTipo:@"verde"]];
        [self runAction:[SKAction playSoundFileNamed:@"correto.aiff" waitForCompletion:NO]];
        [[self myDelegate] testeFinalizado:YES];
        return;
    }
    
    
    [self mostraExclamacao:YES];
    [self runAction:[SKAction playSoundFileNamed:@"exclamacao.mp3" waitForCompletion:NO]];
    //APÓS EXIBIR O NODE EXCLAMAÇÃO É INICIADA UMA ANIMAÇÃO DE ESPERA ANTES DE SER INICIADA A ANIMAÇÃO QUE TESTA A CONDIÇÃO
    [spriteOperador runAction:[SKAction waitForDuration:0.5] completion:^{
        [spriteOperador removeAllActions];
        [spriteOperador iniciarAnimacao];
    }];
}

-(void)resetarValores:(NSString*)valor1 eOperador:(NSString*)operador eValor2:(NSString*)valor2 resultado:(NSString*)resultado{
    
    [spriteOperador removeFromParent];
    spriteOperador = NULL;
    [self criarValores:valor1 eOperador:operador eValor2:valor2 resultado:resultado];
}

-(BOOL)isSenao{
    if([tipoCondicao isEqualToString:@"senao"]){
        return YES;
    }
    
    return NO;
}


-(NSString*)retornaTextoASerExibido{
    return [spriteOperador retornaTextoASerExibido];
}


-(BOOL)retornaVeracidade{
    return [spriteOperador retornaVeracidade];
}


-(void)testeFinalizado{
    [self mostraExclamacao:NO];
    [[self myDelegate] testeFinalizado:[spriteOperador retornaVeracidade]];
}

@end
