//
//  Desafio.h
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 15/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DesafioOperadores : NSObject

{
    int nTasks, nivel, tarefaAtual, nAcertos, nErros;
    NSMutableArray *listaTarefas;
    BOOL desafioConcluido;
    
}
@property NSString *tituloDesafio, *descricaoDesafio;
@property NSString *tipo;


-(id)initWithLevel:(int)nivel andType:(NSString*)tipo andTasks:(int)tasks;
-(int)nTarefas;
-(BOOL)incrementaTarefa;
-(BOOL)decrementaTarefa;
-(NSMutableArray*)retornaTarefas;
-(void)instanciaTarefas;
-(void)montaDesafioNivel:(int)level tipo:(NSString*)type nTarefas:(int)nTarefas;
-(void)finalizaDesafio;
-(BOOL)desafioFinalizado;
-(void)restart;
-(int)acertos;
-(int)erros;
-(int)retornaTarefaAtual;

-(UIColor*)retornaMinhaCor;



-(NSString*)parte1;
-(NSString*)operador;
-(NSString*)parte2;
-(NSString*)resultado;



-(BOOL)respostaDupla;
-(BOOL)corrige:(NSString*)opcao;

@end
