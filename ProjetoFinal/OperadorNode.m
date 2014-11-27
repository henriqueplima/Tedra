//
//  SpriteOperador.m
//  testeSprite
//
//  Created by Felipe Costa Nascimento on 18/07/14.
//  Copyright (c) 2014 Felipe Costa Nascimento. All rights reserved.
//

#import "OperadorNode.h"

@implementation OperadorNode

-(id)initWithOperador:(NSString*)operador{
    self = [super init];
    
    if(self){
        [self inicializaClasse:operador];
    }
    
    return self;
}

-(id)init{
    
    self = [super init];
    
    if(self){
        [self inicializaClasse:@""];
    }
    
    return self;
}

//METODO QUE CHAMA TODOS OS METODOS QUE INICIALIZAM O NECESSÁRIO
-(void)inicializaClasse:(NSString*)operador{
    [self setUserInteractionEnabled:YES];
    [self setTexture:[SKTexture textureWithImageNamed:@"parte-operador.png"]];
    [self setName:@"operador"];
    [self setSize:CGSizeMake(116, 116)];
    [self inicializarLabelOperador:operador];
}

-(void)inicializarLabelOperador:(NSString*)operador{
    lblOperador = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    [lblOperador setName:@"labelOperador"];
    [self setLabelOperador:operador];
    [lblOperador setFontColor:[SKColor whiteColor]];
    [lblOperador setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeCenter];
    [lblOperador setVerticalAlignmentMode:SKLabelVerticalAlignmentModeCenter];
    
    [self addChild:lblOperador];
}

- (void)controlarPelaCena:(BOOL)controlar{
    
    controladoPelaCena = controlar;
    [self setUserInteractionEnabled:!controlar];
    
}


-(void)setLabelOperador:(NSString*)operador{
    
    if([operador isEqualToString:@"&&"]){
        [lblOperador setFontSize: self.size.width * 0.3];
        
    }else{
        [lblOperador setFontSize: self.size.width * 0.5];
    }
    
    [lblOperador setText:operador];
}

- (SKLabelNode *)retornaLabelOperador{
    return lblOperador;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self iniciarAnimacaoDiminuir];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [[self myDelegate] spriteOperadorClicado];
    [self iniciarAnimacaoExpandir];
}





-(void)iniciarAnimacaoDiminuir{
    [lblOperador setFontSize:lblOperador.fontSize - 10];
    [self setSize:CGSizeMake(self.size.width - 10, self.size.height - 10)];
}


-(void)iniciarAnimacaoExpandir{
    [lblOperador setFontSize:lblOperador.fontSize + 10];
    [self setSize:CGSizeMake(self.size.width + 10, self.size.height + 10)];
}

-(NSString*)getOperador{
    return [lblOperador text];
}

-(void)criarCorpo{
    
    self.physicsBody = self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.height / 2];
    self.physicsBody.dynamic = YES;
    self.physicsBody.categoryBitMask = 0x1 << 1;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.density = 0;
    self.physicsBody.usesPreciseCollisionDetection = YES;

    
    
}
@end
