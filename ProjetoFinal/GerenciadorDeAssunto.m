//
//  GerenciadorDeAssunto.m
//  ProjetoFinal
//
//  Created by Kio Coan on 30/06/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "GerenciadorDeAssunto.h"
#import "Variavel.h"
#import "Operadores.h"
#import "CondicaoSimples.h"

//NSString* const FONT_THIN = @"Colaborate-Thin";
//NSString* const FONT_REGULAR = @"Colaborate-Regular";

@implementation GerenciadorDeAssunto

-(id)init{
    self = [super init];
    
    if(self){
        nomesDosAssuntos = [NSArray arrayWithObjects:@"Variáveis",
                            @"Operadores",
                            @"Condicionais",
                            @"em breve",
                            @"em breve",
                            @"em breve",
                            @"em breve",
                            @"em breve",
                            @"em breve",
                            @"em breve",
                            @"em breve",
                            @"em breve",
                            //@"condicaoComposta",
                            //@"lacoFor",
                            //@"lacoWhile",
                            //@"lacoDoWhile",
                            //@"vetor",         SERÃO UTILIZADOS EM ATUALIZAÇÕES FUTURAS
                            //@"matriz",
                            //@"funcaoSimples",
                            //@"funcaoComParametro",
                            //@"funcaoComRetorno",
                            nil];
    }
    
    return self;
}


+ (GerenciadorDeAssunto *)sharedGerenciador{
    static GerenciadorDeAssunto *gerencidaorAssunto = nil;
    
    if (!gerencidaorAssunto) {
        gerencidaorAssunto = [[super allocWithZone:nil]init];
        
    }
    return gerencidaorAssunto;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedGerenciador];
}


-(void)mudarTemaEstudado:(NSString*)tema{
    
    int index = -1;
    //varre o vetor em busca do tema passado como parametro
    for (int i = 0; i < nomesDosAssuntos.count; i++) {
        if ([tema isEqualToString:[nomesDosAssuntos objectAtIndex:i]]) {
            // ao achar o valor salva o indice na variavel index que será utilizada no switch logo abaixo
            index = i;
            break;
            
        }
    }
    
    switch (index) {
        case 0:
            assunto = nil;
            assunto = [[Variavel alloc]init];
            break;
            
        case 1:
            assunto = nil;
            assunto = [[Operadores alloc]init];
            break;
        case 2:
            assunto = nil;
            assunto = [[CondicaoSimples alloc]init];
            break;
        
        
        default:
            assunto = nil;
            break;
    }
    
    
    
    
    
}
-(NSMutableArray*)retornaTeoriaFormatada{
    return [assunto teoriaFormatada];
}


-(NSString*)getNomedoAssunto:(int)pos{
    return [nomesDosAssuntos objectAtIndex:pos];
}

-(NSString*)retornaNomeAssuntoAtual{
    return[assunto nome];
}

-(void)selecionaExercicio:(int)index{
    [assunto selecionaExercicio:index];
}

-(CenaExercicio*)retornaExercicioSelecionado{
    return [assunto retornaExercicioSelecionado];
}

-(void)preparaExercicios{
    [assunto preparaExercicios];
}

-(NSMutableArray*)retornaTitulosEDescricoesExercicios{
    
    return [assunto retornaTitulosEDescricoesExercicios];
}

-(void)instanciaCenaDoExercicio:(int)index{
    [[[assunto exercicios]objectAtIndex:index] instanciaCena];
}

-(int)exercicioSelecionado{
    return [assunto getIndiceExercicio];
}
-(Animacao*)retornaAnimacaoNumero:(int)index{
    
    return [assunto retornaAnimacaoNumero:index];
}


@end
