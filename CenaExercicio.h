//
//  CenaExercicio.h
//  ProjetoFinal
//
//  Created by Henrique Pereira de Lima on 15/08/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <UIKit/UIKit.h>

@protocol CenaExercicioDelegate <NSObject>

- (void)exercicioFinalizado;

@end
@interface CenaExercicio : SKScene

@property id <CenaExercicioDelegate> myDelegate;


@end
