//
//  SpriteOperadorResultado.h
//  testeSprite
//
//  Created by Felipe Costa Nascimento on 18/07/14.
//  Copyright (c) 2014 Felipe Costa Nascimento. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface OperadorResultadoNode : SKSpriteNode
{
    SKAction *animacaoDescer;
    SKAction *animacaoSubir;
    
    BOOL estaVisivel;
}

@property SKLabelNode *lblResultado;


-(id)initWithResultado:(NSString*)resultado;
-(void)setLabelResultado:(NSString*)resultado;
-(SKAction*)getAnimacaoSubir;
-(SKAction*)getAnimacaoDescer;
-(void)iniciarAnimacao;
-(NSString *)getLabelResultado;
-(void)criarCorpo;
@end
