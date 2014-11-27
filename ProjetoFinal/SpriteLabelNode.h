//
//  Conteudo.h
//  Exercicio
//
//  Created by Henrique Pereira de Lima on 08/07/14.
//  Copyright (c) 2014 Henrique Pereira de Lima. All rights reserved.
//

// ##### Classe Especializada utilizada pelo exercício 1 de variáveis ######


#import <SpriteKit/SpriteKit.h>

@interface SpriteLabelNode : SKLabelNode
{
    SKLabelNode *lblTipo;
}

@property NSString *tipo;
@property CGPoint posicaoInicial;
@property BOOL dentro;

- (id)initWithType:(NSString *)tipo texto:(NSString *)texto;
-(void)showTipo;
@end
