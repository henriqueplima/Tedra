//
//  Gerador.m
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 07/08/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "Gerador.h"

@implementation Gerador
{
    NSArray *tipos, *nomesVariaveisInteiros,*nomesVariaveisReais,*nomesVariaveisCaracteres,*nomesVariaveisLogicos,*valoresVariaveisCaracteres, *valoresVariaveisLogicas;
    
}
-(id)init{
    self = [super init];
    if (self) {
        tipos = [NSArray arrayWithObjects:@"real",@"inteiro",@"caractere",@"logico",nil];
        nomesVariaveisInteiros = [NSArray arrayWithObjects:@"idade",
                                  @"quantidade",
                                  @"numeroMesas",
                                  @"numeroAlunos",
                                  @"numeroTeclas",nil];
        
        nomesVariaveisReais = [NSArray arrayWithObjects:@"nota",
                               @"minhaDivida",
                               @"media",
                               @"salario",
                               @"metros",
                               @"litros",nil];
        
        nomesVariaveisCaracteres = [NSArray arrayWithObjects:@"nome",
                                    @"chefe",
                                    @"melhorAmigo",
                                    @"parente",nil];
        nomesVariaveisLogicos = [NSArray arrayWithObjects:@"chovendo",
                                 @"luzAcesa",
                                 @"comSono",
                                 @"carroParado",
                                 @"possuiChave",nil];
        valoresVariaveisCaracteres = [NSArray arrayWithObjects:@"\"Maria\"",
                                      @"\"Pedro\"",
                                      @"\"Joao\"",
                                      @"\"Paulo\"",
                                      @"\"Ana\"",
                                      @"\"Caio\"",
                                      @"\"Henrique\"",
                                      @"\"Fernando\"",
                                      @"\"Gustavo\"",nil];
        valoresVariaveisLogicas = [NSArray arrayWithObjects:@"verdadeiro",@"falso",nil];
    }
    return self;
}

-(NSString*)retornaValorInteiro:(int)inicio ate:(int)fim{
    int aleatorio = arc4random() % (fim+1) + inicio;
    
   return [NSString stringWithFormat:@"%d", aleatorio];

}

-(NSString*)retornaValorFloat:(int)inicio ate:(int)fim{
    int aleatorio = arc4random() % fim + inicio;
    int decimal = arc4random() % 100;
    
    return [NSString stringWithFormat:@"%d.%d", aleatorio, decimal];
}

-(NSString*)retornaValorLogico{
    int num = arc4random() % 2;
    
    switch (num) {
        case 1:
            return @"Verdadeiro";
            
        default:
            return @"Falso";
    }
}

-(NSString *)retornaValorCaractere{
    
    return [self valoresCaracteres];
    
}

-(NSString*)retornaValorAleatorioDoTipo:(NSString*)tipo{
    if([tipo isEqualToString:@"inteiro"]){
        return [self retornaValorInteiro:20 ate:540];
        
    }else if([tipo isEqualToString:@"caractere"]){
        return [self retornaValorCaractere];
        
    }else if ([tipo isEqualToString:@"real"]){
        return [self retornaValorFloat:10 ate:490];
        
    }else{
        return [self retornaValorLogico];
    }
}



-(NSString*)retornaValorAleatorioParaOperador:(NSString*)operador{
    if([operador isEqualToString:@"LÓGICO"]){
        return [self retornaValorLogico];
    
    }else if([operador isEqualToString:@"RELACIONAL"]){
        return [self retornaValorInteiro:1 ate:500];
        
    }else{
        return [self retornaValorFloat:1 ate:100];
    }
}

-(NSString*)retornaOperadorDoTipo:(NSString*)tipoOperador{
    if([tipoOperador isEqualToString:@"RELACIONAL"]){
        return [self retornaOperadorRelacional];
    
    }else if([tipoOperador isEqualToString:@"ARITMÉTICO"]){
        return [self retornaOperadorAritmetico];
    
    }else if([tipoOperador isEqualToString:@"ATRIBUIÇÃO"]){
        return [self retornaOperadorAtribuicao];
    
    }else if([tipoOperador isEqualToString:@"LÓGICO"]){
        return [self retornaOperadorLogico];
    
    }else{
        @throw [NSException exceptionWithName:@"Operador Inválido." reason:@"Operador passado é inválido." userInfo:nil];
    }
}


-(NSString*)retornaOperadorRelacional{
    
    NSArray *operadores = [NSArray arrayWithObjects:@">",@">=",@"<",@"<=",@"==",@"!=", nil];
    
    int i = [[self retornaValorInteiro:0 ate:(int)(operadores.count)-1] intValue];

    return [operadores objectAtIndex:i];
}


-(NSString*)retornaOperadorAritmetico{
    
    NSArray *operadores = [NSArray arrayWithObjects:@"+",@"-",@"*",@"/", nil];
    
    int i = [[self retornaValorInteiro:0 ate:(int)(operadores.count)-1] intValue];
    
    return [operadores objectAtIndex:i];
}


-(NSString*)retornaOperadorAtribuicao{
    
    NSArray *operadores = [NSArray arrayWithObjects:@"+=",@"-=",@"*=",@"/=", nil];
    
    int i = [[self retornaValorInteiro:0 ate:(int)(operadores.count)-1] intValue];
    
    return [operadores objectAtIndex:i];
}


-(NSString*)retornaOperadorLogico{
    NSArray *operadores = [NSArray arrayWithObjects:@"&&",@"||", nil];
    
    int i = [[self retornaValorInteiro:0 ate:(int)(operadores.count)-1] intValue];
    
    return [operadores objectAtIndex:i];
}

// ------------------------------ INICIO MÉTODOS NOMES -----------------------------------
-(NSString*)retornaNomeVariavel:(NSString*)tipo{
    int index = -1;
    for (int i = 0; i<tipos.count; i++) {
        if ([[tipos objectAtIndex:i]isEqualToString:tipo]) {
            index = i;
        }
    }
    NSString *retorno;
    switch (index) {
        case 0: // Tipo Real
            retorno = [self nomesReais];
            break;
          
        case 1: // TIPO INTEIRO
            retorno = [self nomesInteiros];
            break;

        case 2: // TIPO CARACTERES
            retorno = [self nomesCaracteres];
            break;
            
        case 3: // TIPO LOGICA
            retorno = [self nomesLogicos];
            break;
        default:
            retorno = @"";
    }
    return retorno;
}
-(NSString*)nomesInteiros{
    int i = [[self retornaValorInteiro:0 ate:(int)(nomesVariaveisInteiros.count)-1] intValue];
    
    return [nomesVariaveisInteiros objectAtIndex:i];
}

-(NSString*)nomesReais{
    int i = [[self retornaValorInteiro:0 ate:(int)(nomesVariaveisReais.count)-1] intValue];
    
    return [nomesVariaveisReais objectAtIndex:i];
}

-(NSString*)nomesCaracteres{
    int i = [[self retornaValorInteiro:0 ate:(int)(nomesVariaveisCaracteres.count)-1] intValue];
    
    return [nomesVariaveisCaracteres objectAtIndex:i];
}

-(NSString*)nomesLogicos{
    int i = [[self retornaValorInteiro:0 ate:(int)(nomesVariaveisLogicos.count)-1] intValue];
    
    return [nomesVariaveisLogicos objectAtIndex:i];
}
// ------------------------------ FIM MÉTODOS NOMES -----------------------------------



-(NSString*)retornaTipoVariavel{
   
    int i = [[self retornaValorInteiro:0 ate:(int)tipos.count-1]intValue];
    return [tipos objectAtIndex:i];
}

// ------------------------------ INICIO MÉTODOS VALOR -----------------------------------
-(NSString*)retornaValorVarivel:(NSString*)tipo{
    
    int index = -1;
    for (int i = 0; i<tipos.count; i++) {
        if ([[tipos objectAtIndex:i]isEqualToString:tipo]) {
            index = i;
        }
    }
    NSString *retorno;
    int rangeInicio = 1;
    int rangeFim = 100;
    
    switch (index) {
        case 0: // Tipo Real
            retorno = [self retornaValorFloat:rangeInicio ate:rangeFim];
            break;
            
        case 1: // TIPO INTEIRO
            retorno = [self retornaValorInteiro:rangeInicio ate:rangeFim];
            break;
            
        case 2: // TIPO CARACTERES
            retorno = [self valoresCaracteres];
            break;
            
        case 3: // TIPO LOGICA
            retorno = [self valoresLogicas];
            break;
        default:
            retorno = @"";
    }
    return retorno;
}



-(NSString*)valoresCaracteres{
    int i = [[self retornaValorInteiro:0 ate:(int)(valoresVariaveisCaracteres.count)-1] intValue];
    
    return [valoresVariaveisCaracteres objectAtIndex:i];
}
-(NSString*)valoresLogicas{
    int i = [[self retornaValorInteiro:0 ate:(int)(valoresVariaveisLogicas.count)-1] intValue];
    
    return [valoresVariaveisLogicas objectAtIndex:i];
}
// ------------------------------ FIM MÉTODOS VALOR -----------------------------------



-(NSString*)retornaOperadorInverso:(NSString*)op{
    NSString *retorno;
    if ([op isEqualToString:@">"]) {
        retorno = @"<=";
    }else if ([op isEqualToString:@"<="]){
        retorno = @">";
    }else if ([op isEqualToString:@"<"]){
        retorno = @">=";
    }else if ([op isEqualToString:@">="]){
        retorno = @"<";
    }else if ([op isEqualToString:@"=="]){
        retorno = @"!=";
    }else if ([op isEqualToString:@"!="]){
        retorno = @"==";
    }else if ([op isEqualToString:@"&&"]){
        retorno = @"||";
    }else if ([op isEqualToString:@"||"]){
        retorno = @"&&";
    }
    
    return retorno;
    
    
}

@end
