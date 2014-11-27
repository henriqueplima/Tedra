//
//  TipoCondicionalNode.h
//  ProjetoFinal
//
//  Created by Felipe Costa Nascimento on 05/08/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SpriteOperadorCondicional.h"
#import "Calculador.h"

//PROTOCOLO QUE AVISA PARA A CLASSE AnimaCondSimples QUANDO A VERIFICAÇÃO DOS VALORES FOI FINALIZADA
@protocol SpriteCondicaoNodeDelegate <NSObject>
-(void)testeFinalizado:(BOOL)verdadeiro;
@end



@interface SpriteCondicaoNode : SKSpriteNode <SpriteOperadorCondicionalDelegate>
{
    SKSpriteNode *spriteExclamacao;
    NSString *tipoCondicao;
    SpriteOperadorCondicional *spriteOperador;
}
@property id <SpriteCondicaoNodeDelegate> myDelegate;

-(id)initWithType:(NSString*)tipo;
-(NSString*)getTipo;
-(void)criarValores:(NSString*)valor1 eOperador:(NSString*)operador eValor2:(NSString*)valor2 resultado:(NSString*)resultado;
-(void)resetarTextura;
-(void)iniciarTeste;
-(NSString*)retornaTextoASerExibido;
-(BOOL)retornaVeracidade;
-(void)resetarValores:(NSString*)valor1 eOperador:(NSString*)operador eValor2:(NSString*)valor2 resultado:(NSString*)resultado;

@end
