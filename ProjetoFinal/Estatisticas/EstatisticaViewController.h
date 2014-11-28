//
//  ViewController.h
//  MagicPie
//
//  Created by Alexandr on 30.09.13.
//  Copyright (c) 2013 Alexandr Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMSimpleLineGraphView.h"

@interface EstatisticaViewController : UIViewController <BEMSimpleLineGraphDataSource, BEMSimpleLineGraphDelegate>

@property (assign, nonatomic) NSInteger index;
@property NSArray *vtTempos;
@property int nAcertos;
@property NSMutableArray *vetorValores;
@property NSMutableArray *vetorDesafios;
@property BEMSimpleLineGraphView *myGraph;


-(void)finalizarEstatisticas;
@end
