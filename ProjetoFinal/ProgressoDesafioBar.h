//
//  ProgressoDesafioBar.h
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 25/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol ProgressDesafioBarDelegate <NSObject>
-(void)progressBarCompletado;
@end


@interface ProgressoDesafioBar : SKSpriteNode
{
    NSMutableArray *bolinhas;
    SKAction *somAcerto, *somErro;
    int posAtual, nAcertos, nErros;
}

@property id<ProgressDesafioBarDelegate> myDelegate;

-(id)initWithBolinhas:(int)nBolinhas;
-(int)getNAcertos;
-(int)getNErros;
-(void)insereAcerto:(int)index;
-(void)insereErro:(int)index;
-(void)insereAcerto;
-(void)insereErro;
-(void)reset;
@end
