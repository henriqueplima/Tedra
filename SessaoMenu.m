//
//  SecaoMenu.m
//  ProjetoFinal
//
//  Created by Henrique Pereira de Lima on 16/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "SessaoMenu.h"

@implementation SessaoMenu





- (id)init{
    
    self = [super init];
    
    
    if  (self){
        
        [self setUserInteractionEnabled:YES];
        
        
        [self inicializarLabelSessao];
        
    }
    return self;
    
    
}


-(void)inicializarAnimacoesMovimento{
    moverDireita = [SKAction moveToX:self.position.x + 20 duration:0.2];
    [moverDireita setTimingMode:SKActionTimingEaseOut];
    
    moverEsquerda = [SKAction moveToX:self.position.x duration:0.2];
    [moverEsquerda setTimingMode:SKActionTimingEaseIn];
}

-(void)inicializarLabelSessao{
    lblSessao = [SKLabelNode labelNodeWithFontNamed:FONT_MEDIUM];
    [lblSessao setFontSize:22];
    [lblSessao setFontColor:[SKColor whiteColor]];
    [lblSessao setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter];
    [lblSessao setPosition:CGPointMake(23, 0)];
    [lblSessao setZRotation:-M_PI / 2];
    [self addChild:lblSessao];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.myDelegate sessaoAtivada:self.titulo infoIcones:self.tiposIcones];

}


-(void)ativarAnimacaoSecaoAtivada{
    [self runAction:moverDireita];
}


-(void)ativarAnimacaoSecaoDesativada{
    [self runAction:moverEsquerda];
}



- (int)retornaNumeroIcones{
    
    return self.tiposIcones.count;
    
}

- (NSMutableArray *)retornaInfoIcones{
    
    return self.tiposIcones;
    
}


- (NSDictionary *)retornaDictionaryPorIndice:(int)indice{
    
    return [self.tiposIcones objectAtIndex:indice];
    
}


@end
