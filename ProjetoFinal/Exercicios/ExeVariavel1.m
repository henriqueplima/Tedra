//
//  ExeVariavel1.m
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 14/07/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//


// ##### Classe Especializada herdeira de Exercício ######


#import "ExeVariavel1.h"
#import "CenaExercicioVariavel1.h"
@implementation ExeVariavel1


-(id)init{
    self = [super init];
    // ao inicializar o exercício ele seta o título e a descrição do mesmo
    if (self) {
        self.tituloExercicio = [NSString stringWithFormat:@"Movendo valores para suas respectivas variáveis"];
        self.descricaoExercicio = [NSString stringWithFormat:@"Treine o que você aprendeu sobre qual tipo de valor armazenamos em variáveis com diferentes tipos de dados. Arraste os valores para cima das variáveis de acordo com o tipo de dado."];
    }
    return self;
}


-(void)instanciaCena{
    cenaExercicio = [[CenaExercicioVariavel1 alloc] init];
}

-(void)completaExercicio{
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"ExeVariavel1"];
}

-(BOOL)verificaFinalizado{
    return [[NSUserDefaults standardUserDefaults]boolForKey:@"ExeVariavel1"];
}


@end
