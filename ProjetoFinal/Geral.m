//
//  Geral.m
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 17/07/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "Geral.h"

@implementation Geral
{
    Aritimetico *calculadorAritimetico;
    Logico *calculadorLogico;
    Relacional *calculadorRelacional;
}

-(id)init{
    self = [super init];
    if (self) {
        calculadorAritimetico = [[Aritimetico alloc] init];
        calculadorLogico = [[Logico alloc] init];
        calculadorRelacional = [[Relacional alloc] init];
        
        operadores = [NSArray arrayWithObjects:@">",
                                               @">=",
                                               @"<",
                                               @"<=",
                                               @"==",
                                               @"!=",
                                               @"+",
                                               @"+=",
                                               @"-",
                                               @"-=",
                                               @"*",
                                               @"*=",
                                               @"/",
                                               @"/=",
                                               @"&&",
                                               @"||", nil];
    }
    return self;
}

-(NSString*)calculaOperador:(NSString*)operacao numero1:(NSString*)numero1 numero2:(NSString*)numero2{
    
    for(int i=0; i<operadores.count; i++){
        if([operacao isEqualToString:[operadores objectAtIndex:i]]){
            return [self retornaResultado:i numero1:numero1 numero2:numero2];
        }
    }
    
    
    @throw [NSException exceptionWithName:@"Operador Inválido." reason:@"Operador passado é inválido." userInfo:nil];
 
}

-(NSString*)retornaResultado:(int)oper numero1:(NSString*)numero1 numero2:(NSString*)numero2{
    // Converto os dois números pra float
    float convertido1 = [numero1 floatValue];
    float convertido2 = [numero2 floatValue];
    
    switch (oper) {
            
        case 0: // Maior
        case 1: // Maior ou igual
        case 2: // Menor
        case 3: // Menor ou igual
        case 4: // Igual
        case 5: // Diferente
            return [calculadorRelacional calcularComOperadorNome:oper eNumero1:convertido1 eNumero2:convertido2];
            
        case 6: // Soma
        case 7: // Mais igual
            return [calculadorAritimetico soma:convertido1 n2:convertido2];
            
        case 8: // Subtração
        case 9: // Menos igual
            return [calculadorAritimetico subtrai:convertido1 n2:convertido2];
            
        case 10: // Multiplicação
        case 11: // Vezes igual
            return [calculadorAritimetico multiplica:convertido1 n2:convertido2];
            
        case 12: // Divisão
        case 13: // Divido igual
            return [calculadorAritimetico divide:convertido1 n2:convertido2];
            
        case 14: // E Lógico &&
            return [calculadorLogico calcularELogicoExpressao1:numero1 eExpressao2:numero2];
            
        case 15: // Ou lógico ||
            return [calculadorLogico calcularOULogicoExpressao1:numero1 eExpressao2:numero2];
            
        default: // NDA
            return @"Erro";
    }
}


-(NSString*)getOperador:(int)operador{
    if(operador >= operadores.count){
        return @"Erro";
    }
    return [operadores objectAtIndex:operador];
}

@end
