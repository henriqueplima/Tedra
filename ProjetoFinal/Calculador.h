//
//  Calculador.h
//  Calculador
//
//  Created by Rafael Aparecido de Freitas on 03/07/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Geral.h"
@interface Calculador : NSObject
{
    Geral *geral;
}
-(NSString*)calculaOperador:(NSString*)operacao numero1:(NSString*)numero1 numero2:(NSString*)numero2;
-(NSString*)getOperador:(int)operador;

//-(BOOL)oDado:(NSString*)dado eDoTipo:(NSString*)tipo;

@end
