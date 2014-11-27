//
//  Calculador.m
//  Calculador
//
//  Created by Rafael Aparecido de Freitas on 03/07/14.
//  Copyright (c) 2014 Rafael Aparecido de Freitas. All rights reserved.
//

#import "Calculador.h"

@implementation Calculador

-(id)init{
    
    self = [super init];
    
    if (self) {
        geral = [[Geral alloc] init];
        
    }
    return self;
    
}
-(NSString*)calculaOperador:(NSString*)operacao numero1:(NSString*)numero1 numero2:(NSString*)numero2{
    return [geral calculaOperador:operacao numero1:numero1 numero2:numero2];
}
-(NSString*)getOperador:(int)operador{
    return [geral getOperador:operador];
}

@end
