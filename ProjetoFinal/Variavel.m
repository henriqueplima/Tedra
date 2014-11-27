//
//  Variavel.m
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 02/07/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "Variavel.h"
#import "AnimaOperadores.h"
@implementation Variavel

-(id)init{
    
    
    self = [super init];
    
    if (self) {
        [self montaTeoria:@"ConceitosVariaveis"];
        [self setNome:@"Variável"];
        self.cenaAtual = 0;
    }
    return self;
}


-(void)preparaExercicios{
    
    // Aloca os objetos de exercicios
    self.exercicios = [[NSMutableArray alloc] init];
    [self.exercicios addObject:[[ExeVariavel1 alloc] init]];
    [self.exercicios addObject:[[ExeVariavel2 alloc]init]];
}

-(Animacao*)retornaAnimacaoNumero:(int)index{
    
    if (self.cenaAtual == index) {
        return nil;
    }
    
    
    switch (index) {
        case 4:
            return [[AnimaVariavel alloc] initWithVariavelDoTipo:@"INTEIRO"];
            
        case 1:
            return [[AnimaVariavel alloc] initWithVariavelDoTipo:@"REAL"];

        case 5:
            return [[AnimaVariavel alloc] initWithVariavelDoTipo:@"CARACTERE"];
            
        case 6:
            return [[AnimaVariavel alloc] initWithVariavelDoTipo:@"LOGICO"];

        default:
            return nil;
    }
    
    [self setCenaAtual:index];
}


@end
