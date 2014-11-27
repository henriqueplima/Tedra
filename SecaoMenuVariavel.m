//
//  SecaoMenuVariavel.m
//  ProjetoFinal
//
//  Created by Henrique Pereira de Lima on 16/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "SecaoMenuVariavel.h"

@implementation SecaoMenuVariavel


- (id)init{
    
    self = [super init];
    
    if (self) {
        
        
        //DESCOMENTAR QUANDO A IMAGEM JA ESTIVER NO PROJETO, E INSERIR O NOME
        self.texture = [SKTexture textureWithImageNamed:@"livre-variavel.png"];
        self.size = self.texture.size;
        self.name = @"secao";
        self.titulo = @"variavel";
        
        [lblSessao setText:@"variáveis"];
        
        self.tiposIcones = [NSMutableArray array];
        
        NSArray *vetorImagens = [NSArray arrayWithObjects:@"caixa-tipo-inteiro.png", @"caixa-tipo-real.png", @"caixa-tipo-caractere.png", @"caixa-tipo-logico.png",nil];
        NSArray *vetorTipos = [NSArray arrayWithObjects:@"inteiro", @"real",@"caractere",@"logico",nil];
        
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
