//
//  Assunto.m
//  ProjetoFinal
//
//  Created by Kio Coan on 30/06/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//


// #### Classe genérica seus herdeiros serão os assuntos tratados individualmente ######

#import "Assunto.h"

@implementation Assunto



-(void)montaTeoria:(NSString*)nomeDoArquivo{ // Método que formata a teoria vinda de um txt. Este método recebe como parametro o nome do arquivo de origem dos dados
    
    NSString* path = [[NSBundle mainBundle] pathForResource:nomeDoArquivo
                                                     ofType:@"txt"];
    
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    
    [self setTeoriaFormatada:[NSMutableArray arrayWithArray:[content componentsSeparatedByString:@"#"]]];
    
}




-(void)selecionaExercicio:(int)index{
    indiceExercicio = index;
}

-(CenaExercicio*)retornaExercicioSelecionado{
    
    return [[self.exercicios objectAtIndex:indiceExercicio] retornaCena];
}


-(int)getIndiceExercicio{
    return indiceExercicio;
}

-(NSMutableArray*)retornaTitulosEDescricoesExercicios{ //retorna a descrição e os títulos dos exercícios
    
    
    NSMutableArray *titulosEDescricoes = [[NSMutableArray alloc] init];
    
    for (int i = 0; i< self.exercicios.count;i++) {
        
        //Cria um Dicioario com o título e a descrição do exercício e depois adiciona no Vetor
        
        NSDictionary *dict = @{@"titulo": [[self.exercicios objectAtIndex:i] tituloExercicio],
                               @"descricao":[[self.exercicios objectAtIndex:i] descricaoExercicio],
                               @"exercicio":[self.exercicios objectAtIndex:i]
                               };
        [titulosEDescricoes addObject:dict];
    }
    return titulosEDescricoes;
}

-(void)preparaExercicios{
    //Sobrescrever método nas classes filho
}

-(Animacao*)retornaAnimacaoNumero:(int)index{
    //Sobrescrever método nas classes filho
    return nil;
}

@end
