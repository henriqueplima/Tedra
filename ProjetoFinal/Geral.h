//
//  Geral.h
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 17/07/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpriteLabelNode.h"
#import "Logico.h"
#import "Aritimetico.h"
#import "Relacional.h"

@interface Geral : NSObject
{
    NSArray *operadores;
}

-(NSString*)calculaOperador:(NSString*)operacao numero1:(NSString*)numero1 numero2:(NSString*)numero2;
-(NSString*)getOperador:(int)operador;
@end
