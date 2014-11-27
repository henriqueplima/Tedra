//
//  GerenciadorDeAssunto.h
//  ProjetoFinal
//
//  Created by Kio Coan on 30/06/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Assunto.h"
#import "AlteraAnimacaoDelegate.h"
#import "CenaExercicio.h"

//extern NSString* const FONT_THIN;
//extern NSString* const FONT_REGULAR;

@interface GerenciadorDeAssunto : NSObject
{
    NSArray *nomesDosAssuntos;
    Assunto* assunto;
}

+ (GerenciadorDeAssunto *)sharedGerenciador;
+ (id)allocWithZone:(struct _NSZone *)zone;

-(void)mudarTemaEstudado:(NSString*)tema;
-(NSMutableArray*)retornaTeoriaFormatada;
-(NSString*)getNomedoAssunto:(int)pos;
-(NSString*)retornaNomeAssuntoAtual;
-(void)instanciaCenaDoExercicio:(int)index;
-(void)selecionaExercicio:(int)index;
-(CenaExercicio*)retornaExercicioSelecionado;
-(void)preparaExercicios;
-(NSMutableArray*)retornaTitulosEDescricoesExercicios;
-(int)exercicioSelecionado;
-(Animacao*)retornaAnimacaoNumero:(int)index;

@end
