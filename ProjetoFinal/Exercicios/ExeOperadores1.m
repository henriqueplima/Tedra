//
//  ExeOperadores1.m
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 17/07/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "ExeOperadores1.h"

@implementation ExeOperadores1

-(id)init{
    self = [super init];
    // ao inicializar o exercício ele seta o título e a descrição do mesmo
    if (self) {
        self.tituloExercicio = [NSString stringWithFormat:@"Movendo operadores"];
        self.descricaoExercicio = [NSString stringWithFormat:@"Para treinar seus conhecimentos, arraste os operadores para formar expressões de maneira que o resultado seja de acordo com a realidade."];
    }
    return self;
}


-(void)instanciaCena{
    cenaExercicio = [[CenaExercicioOperadores1 alloc] init];
}

-(void)completaExercicio{
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"ExeOperadores1"];
}

-(BOOL)verificaFinalizado{
    return [[NSUserDefaults standardUserDefaults]boolForKey:@"ExeOperadores1"];
}

@end
