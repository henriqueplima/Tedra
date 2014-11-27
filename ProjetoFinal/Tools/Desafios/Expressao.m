//
//  Expressao.m
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 14/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "Expressao.h"
#import "Gerador.h"
#import "Calculador.h"
@implementation Expressao
{
    Gerador *gerador;
    NSString *tipoOperador;
}

-(id)initWithNivel:(int)nivel andOperator:(NSString*)operador{
    self = [super init];
    if (self) {
        gerador = [[Gerador alloc] init];
        nivelExpressao = nivel;
        tipoOperador = operador;
        [self atribuiOperador];
        [self montaPartes];
        [self calculaResultado];
        
    }
    return self;
}

-(NSString*)saidaParte1{
    return [parte1 saida];
}
-(NSString*)saidaParte2{
    return [parte2 saida];
}

-(void)atribuiOperador{
    if ([tipoOperador isEqualToString:@"relacional"]) {
        self.operador = [gerador retornaOperadorRelacional];
    }else{
        self.operador = [gerador retornaOperadorLogico];
    }
}
-(void)montaPartes{
    
    if (nivelExpressao == 2) {
        [self expressao2];
    }else{
        [self expressao];
    }
    
}

-(void)expressao{
    parte1 = [[ParteDaExpressao alloc] initWithNivel:nivelExpressao andOperator:tipoOperador];
    parte2 = [[ParteDaExpressao alloc] initWithNivel:nivelExpressao andOperator:tipoOperador];
}
-(void)expressao2{
    int aleatorio = arc4random() % 2;
    if (aleatorio == 1) {
        parte1 = [[ParteDaExpressao alloc] initWithNivel:nivelExpressao andOperator:tipoOperador];
        parte2 = [[ParteDaExpressao alloc] initWithNivel:1 andOperator:tipoOperador];
    }else{
        parte1 = [[ParteDaExpressao alloc] initWithNivel:1 andOperator:tipoOperador];
        parte2 = [[ParteDaExpressao alloc] initWithNivel:nivelExpressao andOperator:tipoOperador];
    }
}

-(void)calculaResultado{
    Calculador *calculador = [[Calculador alloc] init];
    
    self.resultado = [calculador calculaOperador:self.operador numero1:parte1.resultado numero2:parte2.resultado];
    
    
    NSString *temp = [calculador calculaOperador:[gerador retornaOperadorInverso:self.operador] numero1:parte1.resultado numero2:parte2.resultado];
    
    if ([self.resultado isEqualToString:temp]) {
        self.respostaDupla = YES;
    }else{
        self.respostaDupla = NO;
    }
    
}

@end
