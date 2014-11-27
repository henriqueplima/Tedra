//
//  DesafioVariavel.h
//  ProjetoFinal
//
//  Created by Felipe Costa Nascimento on 9/27/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DesafioVariavel : NSObject
{
    float tempoDeResposta;
    BOOL desafioConcluido;
}

@property NSString *tituloDesafio, *descricaoDesafio;


-(id)initWithTempoDeResposta:(float)segundos;
-(void)instanciaTarefas;
-(UIColor*)retornaMinhaCor;
@end
