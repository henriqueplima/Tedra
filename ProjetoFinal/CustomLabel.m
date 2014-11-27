//
//  CustomLabel.m
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 27/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        }
    return self;
}

-(id)init{
    self = [super init];
    if (self) {
        self.font = [UIFont fontWithName:@"CooperHewitt-Light" size:self.font.pointSize];
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
