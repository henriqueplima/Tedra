//
//  Logico.m
//  Calculador
//
//  Created by Rafael Aparecido de Freitas on 03/07/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import "Logico.h"

@implementation Logico

-(NSString*)calcularELogicoExpressao1:(NSString*)expressao1 eExpressao2:(NSString*)expressao2{
    
    
    BOOL exp1,exp2;
    
    if ([expressao1 isEqualToString:@"Verdadeiro"]) {
        exp1 = YES;
    }else{
        exp1 = NO;
    }
    
    if ([expressao2 isEqualToString:@"Verdadeiro"]) {
        exp2 = YES;
    }else{
        exp2 = NO;
    }
    
    if (exp1 && exp2) {
        return @"Verdadeiro";
    }else{
        return @"Falso";
    }
}


-(NSString*)calcularOULogicoExpressao1:(NSString*)expressao1 eExpressao2:(NSString*)expressao2{
    
    
    BOOL exp1,exp2;
    
    if ([expressao1 isEqualToString:@"Verdadeiro"]) {
        exp1 = YES;
    }else{
        exp1 = NO;
    }
    
    if ([expressao2 isEqualToString:@"Verdadeiro"]) {
        exp2 = YES;
    }else{
        exp2 = NO;
    }
    
    if (exp1 || exp2) {
        return @"Verdadeiro";
    }else{
        return @"Falso";
    }
}


@end
