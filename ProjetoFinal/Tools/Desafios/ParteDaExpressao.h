//
//  ParteDaExpressao.h
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 14/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParteDaExpressao : NSObject
{
    NSString *valor1, *valor2, *operador, *tipoExpressao;
    int nivelParteDaExpressao;
}
-(id)initWithNivel:(int)nivel andOperator:(NSString*)operador;
-(NSString*)saida;
-(NSString*)resultado;

@end
