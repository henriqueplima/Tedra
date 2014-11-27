//
//  DesafioScene.h
//  ProjetoFinal
//
//  Created by Felipe Costa Nascimento on 11/18/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@protocol DesafioSceneDelegate <NSObject>
-(void)exibirDadosEstatisticos:(NSArray*)tempos nAcertos:(int)nAcertos nErros:(int)nErros;
@end



@interface DesafioScene : SKScene

@property id <DesafioSceneDelegate> myDelegate;

@end
