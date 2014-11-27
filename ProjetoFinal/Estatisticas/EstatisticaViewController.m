//
//  ViewController.m
//  MagicPie
//
//  Created by Alexandr on 30.09.13.
//  Copyright (c) 2013 Alexandr Corporation. All rights reserved.
//

#import "EstatisticaViewController.h"
#import "MagicPieLayer.h"
#import "EstatisticaPieView.h"



@interface EstatisticaViewController()
@property EstatisticaPieView* pieView;
@property EstatisticaPieView* pieView2;
@end

@implementation EstatisticaViewController{
    int totalNumber;
}
@synthesize pieView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if (self.index == 0) {
        [self prepararGraficoPizza];
    }else if (self.index == 1){
        [self preparaGraficoLinha];
    }
}


- (void)preparaGraficoLinha{
    
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
    
    
    self.myGraph = [[BEMSimpleLineGraphView alloc]initWithFrame:CGRectMake(0, 100, 768, 350)];
    
    self.myGraph.gradientBottom = CGGradientCreateWithColorComponents(colorspace, components, locations, num_locations);
    
    self.myGraph.dataSource = self;
    self.myGraph.delegate = self;
    self.myGraph.backgroundColor = [UIColor clearColor];
    [self.view bringSubviewToFront:self.myGraph];
    [self.view setUserInteractionEnabled:YES];
    [self.view addSubview:self.myGraph];
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

- (void)criandoDadosAleatorios{
    
    
    for (int i = 0; i < 15; i++) {
        [self.vetorValores addObject:@([self getRandomInteger])];
        [self.vetorDesafios addObject:[NSString stringWithFormat:@"%@", @(2000 + i)]]; // Dates for the X-Axis of the graph
        
        totalNumber = [[self.vetorValores objectAtIndex:i] intValue];
    }
}

- (NSInteger)getRandomInteger
{
    NSInteger i1 = (int)(arc4random() % 10000);
    return i1;
}


- (void)prepararGraficoPizza{
    
    
    float red = 145;
    float green = 186;
    float blue = 193;
    
    CGRect frame = CGRectMake(0, 0, 768, 550);
    self.pieView = [[EstatisticaPieView alloc] initWithFrame:frame];
    [self.pieView setBackgroundColor:[UIColor clearColor]];
    self.pieView.corPadrao = [UIColor colorWithRed:red / 255 green:green / 255 blue:blue / 255 alpha:1];
    [[self view] addSubview:self.pieView];
    
    red = 157;
    green = 78;
    blue = 84;
    
    self.pieView2 = [[EstatisticaPieView alloc] initWithFrame:frame];
    [self.pieView2 setBackgroundColor:[UIColor clearColor]];
    self.pieView2.corPadrao = [UIColor colorWithRed:red / 255 green:green / 255 blue:blue / 255 alpha:1];
    [[self view] addSubview:self.pieView2];
    
    [self iniciarGraficoPizza];
    
    
}

-(float)calcularTempoTotalDesafio{
    float tempoTotal = 0;
    
    for (int i = 0; i < self.vtTempos.count; i++) {
        tempoTotal += [[self.vtTempos objectAtIndex:i] floatValue];
    }
    
    return tempoTotal;
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}


- (void)iniciarGraficoPizza{
    int totalExercicios = self.vtTempos.count;
    int nErros = totalExercicios - self.nAcertos;
    
    //CALCULA A PORCENTAGEM DE ACERTOS
    float porcentagemAcertos = (self.nAcertos * 100) / totalExercicios;
    
    //CALCULA QUANTOS GRAUS REPRESENTA A PORCENTAGEM DE ACERTOS E ERROS
    float grausAcerto = (porcentagemAcertos * 360) / 100;
    float grausErro = 360 - grausAcerto;
    
    //CALCULA O GRAU EM QUE TERMINA OS GRAUS DE ACERTO
    float grauAcertoEnd = 450 - grausAcerto;
    float grauErroEnd = grauAcertoEnd - grausErro;
    
    
    //CONFIGURAÇÃO DA LAYER DA PRIMEIRA VIEW (ACERTOS)
    self.pieView.layer.animationDuration = 0.6;
    self.pieView.layer.startAngle = 450;
    self.pieView.layer.endAngle = grauAcertoEnd;
    self.pieView.layer.showTitles = ShowTitlesAlways;
    
    //CONFIGURAÇÃO DA LAYER DA SEGUNDA VIEW (ERROS)
    self.pieView2.layer.animationDuration = 0.6;
    self.pieView2.layer.startAngle = grauAcertoEnd;
    self.pieView2.layer.endAngle = grauErroEnd;
    self.pieView2.layer.showTitles = ShowTitlesAlways;
    
    
    PieElement* newElem = [PieElement pieElementWithValue:self.nAcertos color:self.pieView.corPadrao];
    newElem.tipoDado = @"Acertos";
    newElem.showTitle = YES;
    int insertIndex = arc4random() % (self.pieView.layer.values.count + 1);
    [self.pieView.layer insertValues:@[newElem] atIndexes:@[@(insertIndex)] animated:YES];
    
    
    PieElement* newElem2 = [PieElement pieElementWithValue:nErros color:self.pieView2.corPadrao];
    newElem2.tipoDado = @"Erros";
    newElem2.showTitle = YES;
    
    //USADO PARA CHAMAR A SEGUNDA VIEW APÓS CERTO DELAY
    [self performSelector:@selector(exibirViewGrafico:) withObject:newElem2 afterDelay:0.4];
    //[self performSelector:<#(SEL)#> withObject:<#(id)#> afterDelay:<#(NSTimeInterval)#>]
    [self.pieView exibirTempoTotal:[NSString stringWithFormat:@"%.1f", [self calcularTempoTotalDesafio]] corTexto:newElem.color];
}

-(void)exibirViewGrafico:(PieElement*)newElem2{
    int insertIndex2 = arc4random() % (self.pieView2.layer.values.count + 1);
    [self.pieView2.layer insertValues:@[newElem2] atIndexes:@[@(insertIndex2)] animated:YES];
    
}


@end


