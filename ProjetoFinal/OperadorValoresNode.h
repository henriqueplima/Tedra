//
//  SpriteOperadorValores.h
//  testeSprite
//
//  Created by Felipe Costa Nascimento on 18/07/14.
//  Copyright (c) 2014 Felipe Costa Nascimento. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface OperadorValoresNode : SKSpriteNode
{
    SKLabelNode *lblValor1;
    SKLabelNode *lblValor2;
    
    SKAction *animacaoExpandir;
    SKAction *animacaoDiminuir;
    
    BOOL estaVisivel;
}

-(id)initWithValor1:(NSString*)valor1 valor2:(NSString*)valor2;
-(void)setLabelValor1:(NSString*)valor1;
-(void)setLabelValor2:(NSString*)valor2;
-(SKAction*)getAnimacaoExpandir;
-(SKAction*)getAnimacaoDiminuir;
-(NSString*)getValor1;
-(NSString*)getValor2;
-(void)iniciarAnimacao;
-(void)ajustarPosicionamentoLabels;
@end
