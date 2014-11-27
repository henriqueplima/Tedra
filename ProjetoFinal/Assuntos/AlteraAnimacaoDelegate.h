//
//  AlteraAnimacaoDelegate.h
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 05/08/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AlteraAnimacaoDelegate <NSObject>

-(void)trocaAnimacao:(int)index;
-(bool)apagaDelegates;
@end
