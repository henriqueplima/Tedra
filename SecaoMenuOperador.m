//
//  SecaoMenuOperador.m
//  ProjetoFinal
//
//  Created by Henrique Pereira de Lima on 18/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "SecaoMenuOperador.h"

@implementation SecaoMenuOperador

- (id)init{
    
    self = [super init];
    
    if (self) {
        
        
        //DESCOMENTAR QUANDO A IMAGEM JA ESTIVER NO PROJETO, E INSERIR O NOME
        self.texture = [SKTexture textureWithImageNamed:@"livre-operador.png"];
        self.size = self.texture.size;
        self.name = @"secao";
        self.titulo = @"operador";
        
        //[self inicializarLabelSessao];
        [lblSessao setText:@"operadores"];

        self.tiposIcones = [NSMutableArray array];
        
        NSArray *vetorImagens = [NSArray arrayWithObjects:@"operador-soma.png", @"operador-subtracao.png", @"operador-multiplicacao.png", @"operador-divisao.png",nil];
        NSArray *vetorTipos = [NSArray arrayWithObjects:@"+", @"-",@"*",@"/",nil];
        
        for (int i = 0; i < vetorTipos.count; i++) {
            
            NSDictionary *dictInfoIcone = @{
                                            @"tipo": [vetorTipos objectAtIndex:i],
                                            @"imagem": [vetorImagens objectAtIndex:i]};
            
            
            [self.tiposIcones addObject:dictInfoIcone];
        }
        
    }
    
    return self;
}


@end
