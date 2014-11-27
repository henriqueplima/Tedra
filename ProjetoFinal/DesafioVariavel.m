//
//  DesafioVariavel.m
//  ProjetoFinal
//
//  Created by Felipe Costa Nascimento on 9/27/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "DesafioVariavel.h"

@implementation DesafioVariavel

-(id)initWithTempoDeResposta:(float)segundos{
    self = [super init];
    
    if(self){
        tempoDeResposta = segundos;
        [self setTituloDesafio:@"Desafio Variável"];
        [self setDescricaoDesafio:@"Toque na caixa que represente o tipo de dado visível na máquina."];
    }
    
    return self;
}

-(void)instanciaTarefas{
    
}
-(UIColor*)retornaMinhaCor{
    UIColor *minhaCor;
    if (desafioConcluido) {
        minhaCor = [UIColor colorWithRed:201.0/255.0 green:195.0/255.0 blue:191.0/255.0 alpha:1.0];
    }else{
        minhaCor = [UIColor colorWithRed:64.0/255.0 green:94.0/255.0 blue:143.0/255.0 alpha:1.0];
    }
    return minhaCor;
}

@end
