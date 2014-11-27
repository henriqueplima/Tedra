//
//  Desafio.m
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 15/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "DesafioOperadores.h"
#import "Expressao.h"
@implementation DesafioOperadores


-(id)initWithLevel:(int)level andType:(NSString *)type andTasks:(int)tasks{
    self = [super init];
    if (self) {
        listaTarefas = [[NSMutableArray alloc] init];
        [self montaDesafioNivel:level tipo:type nTarefas:tasks];
    }
    return self;
}

-(id)init{
    self = [super init];
    if (self) {
        listaTarefas = [[NSMutableArray alloc] init];
        desafioConcluido = NO;
    }
    return self;
}
-(void)montaDesafioNivel:(int)level tipo:(NSString*)type nTarefas:(int)nTarefas{
    nivel = level;
    self.tipo = type;
    nTasks = nTarefas;
    tarefaAtual = 0;
}

-(int)nTarefas{
    return nTasks;
}

-(NSString*)parte1{
    return [[listaTarefas objectAtIndex:tarefaAtual]saidaParte1];
}
-(NSString*)operador{
    return [[listaTarefas objectAtIndex:tarefaAtual]operador];
}
-(NSString*)parte2{
    return [[listaTarefas objectAtIndex:tarefaAtual]saidaParte2];
}
-(NSString*)resultado{
    return [[listaTarefas objectAtIndex:tarefaAtual]resultado];
}
-(BOOL)incrementaTarefa{
    tarefaAtual++;
    if (tarefaAtual >= nTasks) {
        tarefaAtual--;
        [self finalizaDesafio];
        return NO;
    }else{
        
        return YES;
    }
}
-(BOOL)decrementaTarefa{
    tarefaAtual--;
    if (tarefaAtual <= 0) {
        return NO;
    }else{
        return YES;
    }
}
-(NSMutableArray*)retornaTarefas{
    return listaTarefas;
}
-(void)instanciaTarefas{
    for (int i = 0; i<nTasks; i++) {
        [listaTarefas addObject:[[Expressao alloc] initWithNivel:nivel andOperator:self.tipo]];
    }
}
-(BOOL)respostaDupla{
    
    return [[listaTarefas objectAtIndex:tarefaAtual]respostaDupla];
}
-(BOOL)corrige:(NSString*)opcao{
    if ([self respostaDupla] || [[self operador]isEqualToString:opcao]) {
        nAcertos++;
        return YES;
    }else{
        nErros++;
        return NO;
    }
}


-(void)finalizaDesafio{
    desafioConcluido = YES;
}
-(BOOL)desafioFinalizado{
    return desafioConcluido;
}
-(void)restart{
    tarefaAtual = 0;
    desafioConcluido = NO;
    nAcertos = 0;
    nErros = 0;
}
-(int)acertos{
    return nAcertos;
}
-(int)erros{
    return nErros;
}
-(int)retornaTarefaAtual{
    return tarefaAtual;
}
-(UIColor*)retornaMinhaCor{
    UIColor *minhaCor;
    
    if (desafioConcluido) {
        minhaCor = [[UIColor alloc]initWithRed:(201.0/255.0) green:(195.0/255.0) blue:(191.0/255.0) alpha:1.0];
    }else{
        minhaCor = [[UIColor alloc] initWithRed:(76.0/255.0) green:(160.0/255.0) blue:(164.0/255.0) alpha:1.0];
    }
    return minhaCor;
}
@end
