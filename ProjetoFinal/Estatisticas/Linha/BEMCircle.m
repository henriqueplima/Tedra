//
//  BEMCircle.m
//  SimpleLineGraph
//
//  Created by Bobo on 12/27/13. Updated by Sam Spencer on 1/11/14.
//  Copyright (c) 2013 Boris Emorine. All rights reserved.
//  Copyright (c) 2014 Sam Spencer.
//

#import "BEMCircle.h"




@implementation BEMCircle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        //[self addGestureRecognizer:[self criandoGesture]];
        [self criandoGesture];
        [self setUserInteractionEnabled:YES];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, rect);
    [self.Pointcolor set];
    CGContextFillPath(ctx);
    [self setUserInteractionEnabled:YES];
    
}

- (void)criandoGesture{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(fuiClicado:)];
    [tap setNumberOfTapsRequired:1];
    [tap setNumberOfTouchesRequired:1];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    //[tap release];
}

- (void)fuiClicado:(UIGestureRecognizer *)recognizer{
    
    [self.Mydelegate dotSelecionado:self];
    
}

@end