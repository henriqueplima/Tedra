//
//  Validador.m
//  ProjetoFinal
//
//  Created by Henrique Pereira de Lima on 26/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "Validador.h"

@implementation Validador



- (int)transformaStringParaAscii:(NSString *)string{
    
    char caractere = [string characterAtIndex:0];
    return (int) caractere;
    
}

- (BOOL)validaDados:(int)tipo string:(NSString *)string texto:(NSString *)texto{
    
    
    if ([self isCaracterNulo:string]) {
        return YES;
    }
    
    switch (tipo) {
        case 1:
            return [self alfaNumerico:string texto:texto];
            break;
        case 2:
            return [self numerico:string texto:texto];
            break;
        case 3:
            return [self numericoSemPonto:string texto:texto];
            break;
        case 4:
            return [self alfaNumericoSimples:string texto:texto];
            break;
        case 5:
            return [self apenasLetra:string texto:texto];
            break;
        default:
            return NO;
    }
    
    
    
}

- (BOOL)apenasLetra :(NSString *)string texto:(NSString *)texto{
    
    
    [self isCaracterNulo:string];
    
    int indice = [self transformaStringParaAscii:string];
    
    if ([self isLetraMaiuscula:indice]){
        return YES;
    }else if ([self isLetraMinuscula:indice]){
        return YES;
    }
    
    return NO;
    
}

- (BOOL)alfaNumerico :(NSString *)string texto:(NSString *)texto{
    
    
    
    [self isCaracterNulo:string];
    
    int indice = [self transformaStringParaAscii:string];
    
    if ([self naoIniciaComNumero:indice texto:texto]) {
        return YES;
    }else if ([self isLetraMaiuscula:indice]){
        return YES;
    }else if ([self isLetraMinuscula:indice]){
        return YES;
    }
    
    return NO;
}

- (BOOL)alfaNumericoSimples :(NSString *)string texto:(NSString *)texto{
    
    
    
    [self isCaracterNulo:string];
    
    int indice = [self transformaStringParaAscii:string];
    
    if ([self isNumerico:indice]) {
        return YES;
    }else if ([self isLetraMaiuscula:indice]){
        return YES;
    }else if ([self isLetraMinuscula:indice]){
        return YES;
    }
    
    return NO;
}



- (BOOL)numerico: (NSString *)string texto: (NSString *)texto{
    
    if ([self isCaracterNulo:string]) {
        return YES;
    }else{
        
        int indice = [self transformaStringParaAscii:string];
        
        if ([self limiteCaracteres:8 texto:texto]) {
            
            
            if ([self isNumerico:indice]) {
                
                return YES;
                
            }else if ([self isPonto:indice texto:texto]){
                return YES;
            }
            
        }
        
                return NO;
        
    }
    
}

- (BOOL)numericoSemPonto: (NSString *)string texto: (NSString *)texto{
    
    if ([self isCaracterNulo:string]) {
        return YES;
    }else{
        
        int indice = [self transformaStringParaAscii:string];
        
        if ([self limiteCaracteres:8 texto:texto]) {
            
            
            if ([self isNumerico:indice]) {
                
                return YES;
                
            }
            
        }
        
        return NO;
        
    }
    
}


- (BOOL)limiteCaracteres:(int)limite texto:(NSString *)texto{
    
    if (texto.length >= limite) {
        return NO;
    }
    return YES;
}

- (BOOL) naoIniciaComNumero : (int)indice texto:(NSString *)texto{
    
    if (texto.length < 1) {
        return NO;
    }
    
    return [self isNumerico:indice];
}

- (BOOL)isNumerico:(int)indice{
    
    if (indice >= 48 && indice <= 57) {
        return YES;
    }else{
        return NO;
    }
    
}

- (BOOL)isLetraMaiuscula: (int)indice{
    
    if (indice >= 65 && indice <= 90) {
        return YES;
    }else{
        return NO;
    }

}

- (BOOL)isLetraMinuscula: (int)indice{
    
    
    if (indice >= 97 && indice <= 122) {
        return YES;
    }else{
        return NO;
    }

}

- (BOOL)isCaracterNulo:(NSString *)string{
    
    if ([string isEqualToString:@""]) {
        return YES;
    }else{
        return NO;
    }
    
}

- (BOOL)isPonto:(int)indice texto:(NSString *)texto{
    
    if (indice == 46 && texto.length  > 0) {
        
        return [self quantPontos:texto];
        
    }else{
        return NO;
    }
    
}

- (BOOL)quantPontos:(NSString *)texto{
    
    int contador = 0;
    
    for (int i = 0; i < texto.length;i++) {
        
        int caractere = (int) [texto characterAtIndex:i];
        
        if (caractere == 46) {
            contador++;
        }
        
    }
    if (contador > 0) {
        return NO;
    }else{
        return YES;
    }
}

- (NSString *)removeTodoEspaco:(NSString *)string{
    
    NSString *nova = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ( [nova isEqualToString:@""]) {
        return nil;
    }
    
    
    return nova;
}

- (NSString *)removeEspacoDasPontas:(NSString *)string{
    
    
    NSString *nova = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if ([nova isEqualToString:@""]) {
        return nil;
    }
    
    return nova;
}

@end
