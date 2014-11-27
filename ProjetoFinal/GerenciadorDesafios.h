//
//  GerenciadorDesafios.h
//  ProjetoFinal
//
//  Created by RAFAEL APARECIDO DE FREITAS on 17/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DesafioVariavel.h"
#import "DesafioVariavelScene.h"
#import "DesafioOperadores.h"
#import "DesafiosOperadoresScene.h"
extern NSString* const FONT_LIGHT;
extern NSString* const FONT_MEDIUM;

@interface GerenciadorDesafios : NSObject

{
    NSMutableArray *meusDesafios;
    int desafioAtual;
}
@property DesafioScene *cenaAtual;

+ (GerenciadorDesafios*)sharedGerenciador;
+ (id)allocWithZone:(struct _NSZone *)zone;


//NÃO É UTILIZADO
//-(NSMutableArray*)retornaDesafioSelacionado;

-(void)selecionaDesafio:(int)desafio;
-(void)instanciaTarefas;
-(NSMutableArray*)retornaTitulosEDescricoesDesafios;
-(DesafioOperadores*)retornaTarefasParaDesafio;
-(BOOL)corrige:(NSString*)opcao;
-(DesafioScene*)retornaCenaAtual;
-(void)finalizaDesafio;
-(BOOL)desafioFinalizado;
-(void)restartDesafio;
-(void)resetaCena;
-(int)retornaAcertosDesafioAtual;
-(int)retornaErrosDesafioAtual;
-(NSString*)retornaTipoDesafioAtual;
-(UIColor*)retornaCorDesafio:(int)index;



@end
