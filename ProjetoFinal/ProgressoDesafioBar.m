//
//  ProgressoDesafioBar.m
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 25/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "ProgressoDesafioBar.h"

@implementation ProgressoDesafioBar


-(id)initWithBolinhas:(int)nBolinhas{
   
    self = [super init];
    
    if (self) {
        [self inicializarBolinhas:nBolinhas];
        [self inicializarVariaveisContadoras];
        somAcerto = [SKAction playSoundFileNamed:@"correto.aiff" waitForCompletion:NO];
        somErro = [SKAction playSoundFileNamed:@"errado.wav" waitForCompletion:NO];
    
    }
    return self;
}

-(void)inicializarBolinhas:(int)nBolinhas{
    bolinhas = [[NSMutableArray alloc] init];
    CGFloat posY = 0;
    CGFloat posX = 17;

    for (int i=0; i<nBolinhas; i++) {
        [bolinhas addObject:[[SKSpriteNode alloc] initWithImageNamed:@"Desafio-Andamento-Vazio.png"]];
        [[bolinhas objectAtIndex:i]setPosition:CGPointMake(posX, posY)];
        posX +=50;
        [self addChild:[bolinhas objectAtIndex:i]];
    }
    [self setSize:CGSizeMake(posX-33, 33)];
}


-(void)inicializarVariaveisContadoras{
    posAtual = 0;
    nAcertos = 0;
    nErros = 0;
}

-(void)insereAcerto:(int)index{
    [[bolinhas objectAtIndex:index]setTexture:[SKTexture textureWithImageNamed:@"Desafio-Andamento-Correto.png"]];
    [[bolinhas objectAtIndex:index]runAction:somAcerto];
    nAcertos++;
}
-(void)insereErro:(int)index{
    [[bolinhas objectAtIndex:index]setTexture:[SKTexture textureWithImageNamed:@"Desafio-Andamento-Errado.png"]];
    //[[bolinhas objectAtIndex:index]setTexture:textureErrado];
    [[bolinhas objectAtIndex:index]runAction:somErro];
    nErros++;
}
-(void)reset{
    for (int i = 0; i<bolinhas.count; i++) {
        [[bolinhas objectAtIndex:i]setTexture:[SKTexture textureWithImageNamed:@"Desafio-Andamento-Vazio.png"]];
    }
    
    [self inicializarVariaveisContadoras];
}

-(void)insereAcerto{
    if ([self verificarProgressBarCompletado]) {
        return;
    }
    [self insereAcerto:posAtual++];
}

-(void)insereErro{
    if ([self verificarProgressBarCompletado]) {
        return;
    }
    [self insereErro:posAtual++];
}


//VERIFICA SE CHEGOU AO FINAL DO PROGRESS BAR, RETORNA YES CASO TENHA CHEGADO
-(BOOL)verificarProgressBarCompletado{
    if(posAtual == (bolinhas.count - 1)){
        [[self myDelegate] progressBarCompletado];
        return NO;
    
    }else if(posAtual >= bolinhas.count){
        return YES;
    }
    
    return NO;
}


-(int)getNAcertos{
    return nAcertos;
}

-(int)getNErros{
    return nErros;
}
@end
