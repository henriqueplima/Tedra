//
//  ExeCondSimples.m
//  ProjetoFinal
//
//  Created by Henrique Pereira de Lima on 21/07/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "ExeCondSimples1.h"

@implementation ExeCondSimples1

-(id)init{
    self = [super init];
    // ao inicializar o exercício ele seta o título e a descrição do mesmo
    if (self) {
        self.tituloExercicio = [NSString stringWithFormat:@"Montando Condicionais"];
        self.descricaoExercicio = [NSString stringWithFormat:@"Testando a descrição!!."];
    }
    return self;
}


-(void)instanciaCena{
    cenaExercicio = [[CenaExercicioCondSimples1 alloc] init];
}

-(void)completaExercicio{
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"ExeCondSimples1"];
}

-(BOOL)verificaFinalizado{
    return [[NSUserDefaults standardUserDefaults]boolForKey:@"ExeCondSimples1"];
}

@end
