//
//  SpriteOperador.h
//  testeSprite
//
//  Created by Felipe Costa Nascimento on 18/07/14.
//  Copyright (c) 2014 Felipe Costa Nascimento. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
//PROTOCOLO QUE AVISA AO SEU DELEGATE QUANDO O SPRITE QUE CONTEM O OPERADOR FOI CLICADO



@protocol OperadorNodeDelegate <NSObject>
-(void)spriteOperadorClicado;
@end




@interface OperadorNode : SKSpriteNode
{
    SKLabelNode *lblOperador;
    BOOL controladoPelaCena;
}

@property id <OperadorNodeDelegate> myDelegate;

-(id)initWithOperador:(NSString*)operador;
-(void)setLabelOperador:(NSString*)operador;
-(NSString*)getOperador;
-(void)criarCorpo;
- (void)controlarPelaCena:(BOOL)controlar;
- (SKLabelNode *)retornaLabelOperador;
@end
