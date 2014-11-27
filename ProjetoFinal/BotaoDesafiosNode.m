//
//  BotaoDesafiosNode.m
//  ProjetoFinal
//
//  Created by RAFAEL APARECIDO DE FREITAS on 18/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "BotaoDesafiosNode.h"

@implementation BotaoDesafiosNode



-(id)initWithImageNamed:(NSString *)name{
    
    self = [super initWithImageNamed:name];
    if (self) {
        valor = [[SKLabelNode alloc] initWithFontNamed:FONT_LIGHT];
        valor.fontSize = self.size.width / valor.frame.size.width + 20;
        [valor setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter];
        [valor setVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter];
        [self addChild:valor];
        //[valor setPosition:CGPointMake(50, 50)];
        
    }
    return self;
}

-(void)setValor:(NSString *)texto{
    [valor setText:texto];
    //valor.fontSize = self.size.width / valor.frame.size.width + 20;
    valor.fontSize = 90.0;
}

-(NSString*)text{
    return valor.text;
}

-(void)setName:(NSString *)name{
    [super setName:name];
    [valor setName:name];
    
}

@end
