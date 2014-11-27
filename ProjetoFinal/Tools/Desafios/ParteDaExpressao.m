//
//  ParteDaExpressao.m
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 14/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "ParteDaExpressao.h"
#import "Calculador.h"
#import "Gerador.h"
@implementation ParteDaExpressao

-(id)initWithNivel:(int)nivel andOperator:(NSString*)tipo{
    self = [super init];
    if (self) {
        nivelParteDaExpressao = nivel;
        tipoExpressao = tipo;
        [self montaParte];
        
    }
    return self;
}

-(NSString*)saida{

    if (nivelParteDaExpressao == 1) {
        return valor1;
    }
    return [NSString stringWithFormat:@"(%@ %@ %@)",valor1,operador,valor2];
}
-(NSString*)resultado{
    if ([operador isEqualToString:@""]) {
        return valor1;
    }
    Calculador *calculador = [[Calculador alloc] init];
    return [calculador calculaOperador:operador numero1:valor1 numero2:valor2];
}

-(void)montaParte{
    switch (nivelParteDaExpressao) {
        case 1:
            [self nivel1];
            break;
        case 2:
            [self nivel2];
            break;
        default:
            [self nivel2];
            break;
    }
}
-(void)nivel1{
    Gerador *gerador = [[Gerador alloc] init];
    if ([tipoExpressao isEqualToString:@"relacional"]) {
        valor1 = [gerador retornaValorInteiro:1 ate:20];
        valor2 = @"";
        operador = @"";
    }else{
        valor1 = [gerador retornaValorLogico];
        valor2 = @"";
        operador = @"";
    }
    
    
    
}
-(void)nivel2{
    Gerador *gerador = [[Gerador alloc] init];
    
    if ([tipoExpressao isEqualToString:@"relacional"]) {
        valor1 = [gerador retornaValorInteiro:1 ate:10];
        valor2 = [gerador retornaValorInteiro:1 ate:10];
        operador = [gerador retornaOperadorAritmetico];
        while ([operador isEqualToString:@"/"]) {
            operador = [gerador retornaOperadorAritmetico];
        }
    }else{
        valor1 = [gerador retornaValorLogico];
        valor2 = [gerador retornaValorLogico];
        operador = [gerador retornaOperadorLogico];
    }
    
    
}
-(void)nivel3{
    Gerador *gerador = [[Gerador alloc] init];
    valor1 = [gerador retornaValorInteiro:10 ate:20];
    valor2 = [gerador retornaValorInteiro:10 ate:20];
    operador = [gerador retornaOperadorAritmetico];
}



@end
