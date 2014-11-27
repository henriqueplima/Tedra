//
//  ExamplePieView.m
//  MagicPie
//
//  Created by Alexandr on 10.10.13.
//  Copyright (c) 2013 Alexandr Corporation. All rights reserved.
//

#import "EstatisticaPieView.h"

@interface EstatisticaPieView ()
{
    CGPoint panNormalizedVector;
    PieElement* panPieElem;
    float panStartCenterOffsetElem;
    float panStartDotProduct;
    BOOL labelInseridas;
}
@end

@implementation EstatisticaPieView

+ (Class)layerClass
{
    return [PieLayer class];
}

- (id)init
{
    self = [super init];
    if(self){
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self setup];
        
    }
    return self;
}

- (void)setup
{
    //DEFINE A ESPESSURA DO CIRCULO EXTERNO E INTERNO
    self.layer.maxRadius = 155;
    self.layer.minRadius = 105;
    
    self.layer.animationDuration = 0.6;
    self.layer.showTitles = ShowTitlesIfEnable;
    if ([self.layer.self respondsToSelector:@selector(setContentsScale:)])
    {
        self.layer.contentsScale = [[UIScreen mainScreen] scale];
        self.layer.myDelegate = self;
        
    }
    
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
    
    //UIPanGestureRecognizer* pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    //pan.maximumNumberOfTouches = 1;
    //[self addGestureRecognizer:pan];
}

- (void)handleTap:(UITapGestureRecognizer*)tap
{
    if(tap.state != UIGestureRecognizerStateEnded)
        return;
    
    CGPoint pos = [tap locationInView:tap.view];
    PieElement* elem = [self.layer pieElemInPoint:pos];
    if(elem && _elemTapped)
        _elemTapped(elem);
}

- (void)handlePan:(UIPanGestureRecognizer*)pan
{
    CGPoint pos = [pan locationInView:pan.view];
    CGPoint center = CGPointMake(pan.view.frame.size.width / 2, pan.view.frame.size.height / 2);
    if(pan.state == UIGestureRecognizerStateBegan){
        panPieElem = [self.layer pieElemInPoint:pos];
        panStartCenterOffsetElem = panPieElem.centrOffset;
        
        CGPoint vec = CGPointMake(pos.x - center.x, pos.y - center.y);
        float distance = sqrtf(pow(vec.x, 2.0) + pow(vec.y, 2.0));
        panNormalizedVector = CGPointMake(vec.x / distance, vec.y / distance);
        panStartDotProduct = distance;
    } else if(pan.state == UIGestureRecognizerStateChanged){
        CGPoint currPoint = CGPointMake(pos.x - center.x, pos.y - center.y);
        float dotProduct = currPoint.x * panNormalizedVector.x + currPoint.y * panNormalizedVector.y;
        panPieElem.centrOffset = MAX(0.0, dotProduct - panStartDotProduct + panStartCenterOffsetElem);
    } else if(pan.state == UIGestureRecognizerStateEnded){
        panPieElem = nil;
    }
}


-(void)exibirTempoTotal:(NSString*)tempoTotal corTexto:(UIColor*)cor{
    
    UILabel *labelTempo = [[UILabel alloc] init];
    [labelTempo setText:tempoTotal];
    [labelTempo setFont:[UIFont fontWithName:FONT_MEDIUM size:64]];
    //[labelTempo setTextColor:cor];
    [labelTempo setTextColor:[UIColor whiteColor]];
    CGSize requiredSize = [tempoTotal sizeWithAttributes: @{NSFontAttributeName: labelTempo.font}];
    
    
    CGRect frameTempo;
    frameTempo.size.width = requiredSize.width;
    frameTempo.size.height = requiredSize.height + 5;
    frameTempo.origin.x = (self.frame.size.width - frameTempo.size.width) / 2;
    frameTempo.origin.y = ((self.frame.size.height - frameTempo.size.height) / 2) - 15;
    
    [labelTempo setFrame:frameTempo];
    [self addSubview:labelTempo];
    
    
    //TEXTO "SEGUNDOS"
    UILabel *labelSegundos = [[UILabel alloc] init];
    [labelSegundos setText:@"segundos"];
    [labelSegundos setFont:[UIFont fontWithName:FONT_LIGHT size:40]];
    [labelSegundos setTextColor:[UIColor whiteColor]];
    requiredSize = [@"segundos" sizeWithAttributes: @{NSFontAttributeName: labelSegundos.font}];
    

    frameTempo.size.width = requiredSize.width;
    frameTempo.size.height = requiredSize.height + 5;
    frameTempo.origin.x = (self.frame.size.width - frameTempo.size.width) / 2;
    frameTempo.origin.y += 55;
    
    [labelSegundos setFrame:frameTempo];
    [self addSubview:labelSegundos];
}

-(void)labelsPreparadas:(UILabel *)label1 label2:(UILabel *)label2{
    if (labelInseridas) {
        return;
    }
    [label1 setTextColor:self.corPadrao];
    [label2 setTextColor:[UIColor whiteColor]];
    
    [self addSubview:label1];
    [self addSubview:label2];
    labelInseridas = YES;
    
    
}
@end
