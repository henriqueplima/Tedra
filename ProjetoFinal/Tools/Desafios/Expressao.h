//
//  Expressao.h
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 14/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParteDaExpressao.h"

@interface Expressao : NSObject
{
    
    ParteDaExpressao *parte1, *parte2;
    int nivelExpressao;
}
@property BOOL respostaDupla;
@property NSString *operador, *resultado;

-(id)initWithNivel:(int)nivel andOperator:(NSString*)operador;

-(NSString*)saidaParte1;
-(NSString*)saidaParte2;



@end
