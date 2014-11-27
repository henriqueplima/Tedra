//
//  GerenciadorDesafios.m
//  ProjetoFinal
//
//  Created by RAFAEL APARECIDO DE FREITAS on 17/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "GerenciadorDesafios.h"

NSString* const FONT_LIGHT = @"CooperHewitt-Light";
NSString* const FONT_MEDIUM = @"CooperHewitt-Medium";

@implementation GerenciadorDesafios


+ (GerenciadorDesafios*)sharedGerenciador{
    static GerenciadorDesafios *gerencidaorDesafios = nil;
    
    if (!gerencidaorDesafios) {
        gerencidaorDesafios = [[super allocWithZone:nil]init];
        
    }
    return gerencidaorDesafios;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedGerenciador];
}

-(id)init{
    self = [super init];
    if (self) {
        meusDesafios = [[NSMutableArray alloc] init];
        [self criaDesafios];
    }
    return self;
}

-(void)criaDesafios{
    
    [meusDesafios addObject:[[DesafioVariavel alloc] initWithTempoDeResposta:5]]; // DESAFIO 1 - LÓGICO FÁCIL
    
    [meusDesafios addObject:[self retornaDesafioNivel:1 tipo:@"logico" nTarefas:10]]; // DESAFIO 1 - LÓGICO FÁCIL
    [meusDesafios addObject:[self retornaDesafioNivel:1 tipo:@"relacional" nTarefas:10]]; // DESAFIO 2 - RELACIONAL FÁCIL
    [meusDesafios addObject:[self retornaDesafioNivel:2 tipo:@"logico" nTarefas:15]]; // DESAFIO 3 - LOGICO MÉDIO
    [meusDesafios addObject:[self retornaDesafioNivel:2 tipo:@"relacional" nTarefas:15]]; // DESAFIO 4 - RELACIONAL MÉDIO
    [meusDesafios addObject:[self retornaDesafioNivel:3 tipo:@"logico" nTarefas:10]]; // DESAFIO 5 - LOGICO DIFÍCIL
    [meusDesafios addObject:[self retornaDesafioNivel:2 tipo:@"relacional" nTarefas:10]]; // DESAFIO 6 - RELACIONAL DIFÍCIL
}


-(DesafioOperadores*)retornaDesafioNivel:(int)level tipo:(NSString*)type nTarefas:(int)nTarefas{
    
    DesafioOperadores *d = [[DesafioOperadores alloc] initWithLevel:level andType:type andTasks:nTarefas];
    switch (meusDesafios.count+1) {
        case 1:
            [d setTituloDesafio:@"Desafio 1"];
            [d setDescricaoDesafio:@"Resolva 10 exercícios de operadores lógicos"];
            break;
        case 2:
            [d setTituloDesafio:@"Desafio 2"];
            [d setDescricaoDesafio:@"Resolva 10 exercícios de operadores relacionais"];
            break;
        case 3:
            [d setTituloDesafio:@"Desafio 3"];
            [d setDescricaoDesafio:@"Resolva 15 exercícios de operadores logicos"];
            break;
        case 4:
            [d setTituloDesafio:@"Desafio 4"];
            [d setDescricaoDesafio:@"Resolva 15 exercícios de operadores relacionais"];
            break;
        case 5:
            [d setTituloDesafio:@"Desafio 5"];
            [d setDescricaoDesafio:@"Resolva 10 exercícios de operadores logicos - DIFÍCIL"];
            break;
        case 6:
            [d setTituloDesafio:@"Desafio 6"];
            [d setDescricaoDesafio:@"Resolva 10 exercícios de operadores relacionais - DIFÍCIL"];
            break;
        
        default:
            [d setTituloDesafio:@"Atribua um título"];
            [d setDescricaoDesafio:@"Atribua uma descrição"];
            break;
    }
    
    return d;
}

-(DesafioScene*)retornaCenaAtual{
    
    switch (desafioAtual) {
        case 0:
            self.cenaAtual = [[DesafioVariavelScene alloc] initWithSize:CGSizeMake(768, 1024)];
            break;
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
            self.cenaAtual = [[DesafiosOperadoresScene alloc] init];
            break;
        default:
            break;
    }
    return self.cenaAtual;
}



-(void)selecionaDesafio:(int)desafio{
    desafioAtual = desafio;
}

//NÃO É UTILIZADO
//-(NSMutableArray*)retornaDesafioSelacionado{
//    
//    return [[meusDesafios objectAtIndex:desafioAtual] retornaTarefas];
//}

-(void)instanciaTarefas{
    [[meusDesafios objectAtIndex:desafioAtual] instanciaTarefas];
}

-(NSMutableArray*)retornaTitulosEDescricoesDesafios{ //retorna a descrição e os títulos dos exercícios
    
    
    NSMutableArray *titulosEDescricoes = [[NSMutableArray alloc] init];
    
    for (int i = 0; i< meusDesafios.count;i++) {
        
        //Cria um Dicioario com o título e a descrição do exercício e depois adiciona no Vetor
        
        NSDictionary *dict = @{@"titulo": [[meusDesafios objectAtIndex:i] tituloDesafio],
                               @"descricao":[[meusDesafios objectAtIndex:i] descricaoDesafio],
                               @"desafio":[meusDesafios objectAtIndex:i]
                               };
        [titulosEDescricoes addObject:dict];
    }
    return titulosEDescricoes;
}

-(DesafioOperadores*)retornaTarefasParaDesafio{
    return [meusDesafios objectAtIndex:desafioAtual];
    
}
-(BOOL)corrige:(NSString*)opcao{
    return [[meusDesafios objectAtIndex:desafioAtual]corrige:opcao];
}

-(void)finalizaDesafio{
    [[meusDesafios objectAtIndex:desafioAtual]finalizaDesafio];
}
-(BOOL)desafioFinalizado{
    return [[meusDesafios objectAtIndex:desafioAtual]desafioFinalizado];
}
-(void)resetaCena{
    [self retornaCenaAtual];
}
-(void)restartDesafio{
    [[meusDesafios objectAtIndex:desafioAtual]restart];
}
-(int)retornaAcertosDesafioAtual{
    return [[meusDesafios objectAtIndex:desafioAtual]acertos];
}
-(int)retornaErrosDesafioAtual{
    return [[meusDesafios objectAtIndex:desafioAtual]erros];
}
-(NSString*)retornaTipoDesafioAtual{
    return [[meusDesafios objectAtIndex:desafioAtual]tipo];
}
-(UIColor*)retornaCorDesafio:(int)index{
    UIColor *cor = [[meusDesafios objectAtIndex:index]retornaMinhaCor];
    return cor;
}
@end
