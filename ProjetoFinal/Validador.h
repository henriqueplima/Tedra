//
//  Validador.h
//  ProjetoFinal
//
//  Created by Henrique Pereira de Lima on 26/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validador : NSObject

@property int numeroErros;

- (NSString *)removeTodoEspaco:(NSString *)string;
- (NSString *)removeEspacoDasPontas:(NSString *)string;
- (BOOL)validaDados:(int)tipo string:(NSString *)string texto:(NSString *)texto;




@end
