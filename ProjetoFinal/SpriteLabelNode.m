//
//  Conteudo.m
//  Exercicio
//
//  Created by Henrique Pereira de Lima on 08/07/14.
//  Copyright (c) 2014 Henrique Pereira de Lima. All rights reserved.
//

// ##### Classe Especializada utilizada pelo exercício 1 de variáveis ######

#import "SpriteLabelNode.h"


@implementation SpriteLabelNode

- (id)initWithType:(NSString *)tipo texto:(NSString *)texto{
    
    
    self = [super init];
    
    if (self) {
        [self setTipo:tipo];
        [self setText:texto];
        [self setName:@"conteudo"];
        [self setFontName:@"Chalkduster"];
        
    }  
    
    return self;
    
}


-(void)showTipo{
    lblTipo = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica Bold"];
    [lblTipo setText:self.tipo];
    [lblTipo setFontColor:[SKColor colorWithRed:0.8 green:0.4 blue:0.2 alpha:1]];
    [lblTipo setPosition:CGPointMake(self.position.x - 55, 0)];
    [lblTipo setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeRight];
    [lblTipo setFontSize:self.fontSize];
    [self addChild:lblTipo];

}


@end
