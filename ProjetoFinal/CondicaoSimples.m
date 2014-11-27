//
//  CondicaoSimples.m
//  ProjetoFinal
//
//  Created by Henrique Pereira de Lima on 21/07/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "CondicaoSimples.h"

@implementation CondicaoSimples

-(id)init{
    
    
    self = [super init];
    
    if (self) {
        [self montaTeoria:@"ConceitosCondicionais"];
        [self setNome:@"Condição Simples"];
        self.cenaAtual = 0;
        
    }
    return self;
}


-(void)preparaExercicios{ // Aloca os objetos herdeiros, não instancia a cena dos exercícios
    
    
    
    self.exercicios = [[NSMutableArray alloc] init];
    [self.exercicios addObject:[[ExeCondSimples1 alloc] init]];
    
}

-(Animacao*)retornaAnimacaoNumero:(int)index{
    
    if (self.cenaAtual == index) {
        return nil;
    }
    
    switch (index) {
        case 1:
            return [[AnimaCondSimples alloc] initWithCondicao:@"SE"];
            
        case 3:
            return [[AnimaCondSimples alloc] initWithCondicao:@"SE-SENAO"];
            
        case 4:
            return [[AnimaCondSimples alloc] initWithCondicao:@"SE-SENAOSE"];
            
        case 5:
            return [[AnimaCondSimples alloc] initWithCondicao:@"SE-SENAOSE-SENAO"];
            
        default:
            return nil;
    }
    
    [self setCenaAtual:index];
}



@end
