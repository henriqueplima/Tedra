//
//  TestandoLinhaViewController.m
//  ProjetoFinal
//
//  Created by Henrique Pereira de Lima on 24/11/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "GraficoLinhaViewController.h"

@interface GraficoLinhaViewController (){
    int totalNumber;
}

@end

@implementation GraficoLinhaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.vetorDesafios = [NSMutableArray array];
    self.vetorValores = [NSMutableArray array];
    
    
    [self criandoDadosAleatorios];
    
    // Configurando o Grafico
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = {
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 0.0
    };
    self.myGraph.gradientBottom = CGGradientCreateWithColorComponents(colorspace, components, locations, num_locations);
    
    self.myGraph.dataSource = self;
    self.myGraph.delegate = self;
    [self.view bringSubviewToFront:self.myGraph];
    [self.view setUserInteractionEnabled:YES];
    //self.myGraph.backgroundColor = [UIColor blackColor];
//    self.myGraph.colorTop = color;
//    self.myGraph.colorBottom = color;
//    self.myGraph.colorLine = [UIColor whiteColor];
//    self.myGraph.colorXaxisLabel = [UIColor whiteColor];
//    self.myGraph.colorYaxisLabel = [UIColor whiteColor];
    
    
    //self.myGraph.widthLine = 3.0;
//    self.myGraph.enableTouchReport = YES;
//    self.myGraph.enablePopUpReport = YES;
//    self.myGraph.enableBezierCurve = NO;
//    self.myGraph.enableYAxisLabel = NO; // Retira Labels Vertical
//    self.myGraph.enableXAxisLabel = NO;
//    self.myGraph.autoScaleYAxis = YES;
//    self.myGraph.alwaysDisplayDots = YES;
//    self.myGraph.enableReferenceXAxisLines = NO;
//    self.myGraph.enableReferenceYAxisLines = NO;
//    self.myGraph.enableReferenceAxisFrame = YES;
//    self.myGraph.animationGraphStyle = BEMLineAnimationDraw;
    
}

- (NSInteger)getRandomInteger
{
    NSInteger i1 = (int)(arc4random() % 10000);
    return i1;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)criandoDadosAleatorios{
    
    
    for (int i = 0; i < 15; i++) {
        [self.vetorValores addObject:@([self getRandomInteger])];
        [self.vetorDesafios addObject:[NSString stringWithFormat:@"%@", @(2000 + i)]]; // Dates for the X-Axis of the graph
        
        totalNumber = [[self.vetorValores objectAtIndex:i] intValue];
    }

    
    
}


#pragma mark - SimpleLineGraph Data Source

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    return (int)[self.vetorValores count];
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    return [[self.vetorValores objectAtIndex:index] floatValue];
}


#pragma mark - SimpleLineGraph Delegate

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    return 1;
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    NSString *label = [self.vetorDesafios objectAtIndex:index];
    return [label stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didTouchGraphWithClosestIndex:(NSInteger)index {
    
    /*
    self.labelValues.text = [NSString stringWithFormat:@"%@", [self.arrayOfValues objectAtIndex:index]];
    self.labelDates.text = [NSString stringWithFormat:@"in %@", [self.arrayOfDates objectAtIndex:index]]; */
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didReleaseTouchFromGraphWithClosestIndex:(CGFloat)index {
   /* [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.labelValues.alpha = 0.0;
        self.labelDates.alpha = 0.0;
    } completion:^(BOOL finished) {
        self.labelValues.text = [NSString stringWithFormat:@"%i", [[self.myGraph calculatePointValueSum] intValue]];
        self.labelDates.text = [NSString stringWithFormat:@"between %@ and %@", [self.arrayOfDates firstObject], [self.arrayOfDates lastObject]];
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.labelValues.alpha = 1.0;
            self.labelDates.alpha = 1.0;
        } completion:nil];
    }]; */
}

- (void)lineGraphDidFinishLoading:(BEMSimpleLineGraphView *)graph {
    
    /*
    self.labelValues.text = [NSString stringWithFormat:@"%i", [[self.myGraph calculatePointValueSum] intValue]];
    self.labelDates.text = [NSString stringWithFormat:@"between %@ and %@", [self.arrayOfDates firstObject], [self.arrayOfDates lastObject]];
     
     */
}






/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
