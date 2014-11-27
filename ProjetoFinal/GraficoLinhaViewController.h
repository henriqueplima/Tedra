//
//  TestandoLinhaViewController.h
//  ProjetoFinal
//
//  Created by Henrique Pereira de Lima on 24/11/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BEMSimpleLineGraphView.h"

@interface GraficoLinhaViewController : UIViewController <BEMSimpleLineGraphDataSource,BEMSimpleLineGraphDelegate>

@property (weak, nonatomic) IBOutlet BEMSimpleLineGraphView *myGraph;
@property NSMutableArray *vetorValores;
@property NSMutableArray *vetorDesafios;
@end
