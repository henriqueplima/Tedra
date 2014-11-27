//
//  ExamplePieView.h
//  MagicPie
//
//  Created by Alexandr on 10.10.13.
//  Copyright (c) 2013 Alexandr Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MagicPieLayer.h"

@class PieLayer, PieElement;

@interface EstatisticaPieView : UIView <PieLayerDelegate>
@property (nonatomic, copy) void(^elemTapped)(PieElement*);
@property UIColor *corPadrao;
@end

@interface EstatisticaPieView (ex)
@property(nonatomic,readonly,retain) PieLayer *layer;


-(void)exibirTempoTotal:(NSString*)tempoTotal corTexto:(UIColor*)cor;
@end