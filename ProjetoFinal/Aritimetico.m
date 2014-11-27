//
//  Aritimetico.m
//  Calculador
//
//  Created by Rafael Aparecido de Freitas on 03/07/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import "Aritimetico.h"

@implementation Aritimetico

// Métodos dos operadores aritiméticos
-(NSString*)soma:(float)n1 n2:(float)n2{
    
    NSString *soma;
    // Caso o resultado da soma seja um inteiro ele retorna uma string formatada como inteiro do contrario faz a formatação para float
    if ((floorf(n1+n2)==(n1+n2))) {
        soma =  [NSString stringWithFormat:@"%d",((int)n1) + ((int)n2)];
    }else{
        soma = [NSString stringWithFormat:@"%.02f",n1 + n2];
    }

    return soma;
}

-(NSString*)subtrai:(float)n1 n2:(float)n2{
    
    NSString *subtracao;
    // Caso o resultado da subtração seja um inteiro ele retorna uma string formatada como inteiro do contrario faz a formatação para float
    if ((floorf(n1-n2)==(n1-n2))) {
        subtracao =  [NSString stringWithFormat:@"%d",((int)n1) - ((int)n2)];
    }else{
        subtracao = [NSString stringWithFormat:@"%.02f",n1 - n2];
    }
    
    return subtracao;
}

-(NSString*)multiplica:(float)n1 n2:(float)n2{
    
    //Caso algum número seja 0 ja retorna 0 como resposta
    if ((n2 == 0)||(n1 == 0)) {
        return [NSString stringWithFormat:@"0"];
    }
    
    
    NSString *multiplicacao;
    // Caso o resultado da multiplicação seja um inteiro ele retorna uma string formatada como inteiro do contrario faz a formatação para float
    if ((floorf(n1*n2)==(n1*n2))) {
        multiplicacao =  [NSString stringWithFormat:@"%d",((int)n1) * ((int)n2)];
    }else{
        multiplicacao = [NSString stringWithFormat:@"%.02f",n1 * n2];
    }
    
    return multiplicacao;
}

-(NSString*)divide:(float)n1 n2:(float)n2{
    
    //Caso algum número seja 0 ja retorna 0 como resposta
    if ((n2 == 0)||(n1 == 0)) {
        return [NSString stringWithFormat:@"0"];
    }
    
    
    NSString *divisao;
    // Caso o resultado da divisão seja um inteiro ele retorna uma string formatada como inteiro do contrario faz a formatação para float
    if ((floorf(n1/n2)==(n1/n2))) {
        divisao =  [NSString stringWithFormat:@"%d",((int)n1) / ((int)n2)];
    }else{
        divisao = [NSString stringWithFormat:@"%.02f",n1 / n2];
    }
    
    return divisao;
}


@end
