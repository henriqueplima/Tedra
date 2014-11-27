//
//  SpriteOperadorNode.m
//  testeSprite
//
//  Created by Felipe Costa Nascimento on 18/07/14.
//  Copyright (c) 2014 Felipe Costa Nascimento. All rights reserved.
//

#import "SpriteOperadorNode.h"

@implementation SpriteOperadorNode


-(id)init{
    self = [super init];
    
    if(self){
        [self inicializaClasse:@"" operador:@"" valor2:@"" resultado:@""];
    }
    
    return self;
}


-(id)initWithValor1:(NSString*)valor1 operador:(NSString*)operador valor2:(NSString*)valor2 resultado:(NSString*)resultado{
    if(self = [super init]){
        [self inicializaClasse:valor1 operador:operador valor2:valor2 resultado:resultado];
    }
    
    return self;
}

- (void)controladoPelaCena:(BOOL)controlar{
    controladoPelaCena = controlar;
    [self setUserInteractionEnabled:!controlar];
    [nodeOperador controlarPelaCena:controlar];
}

-(void)inicializaClasse:(NSString*)valor1 operador:(NSString*)operador valor2:(NSString*)valor2 resultado:(NSString*)resultado{
    
    //THREAD PARA CRIAR A ANIMAÇÃO COM SOM
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        somOperador = [SKAction playSoundFileNamed:@"operadores.mp3" waitForCompletion:NO];
    });
    
    //A PARTE QUE É EXIBIDO O RESULTADO É A PRIMEIRA A SER INSERIDA PRA QUE ELA FIQUE POR TRÁS DAS OUTRAS
    nodeResultado = [[OperadorResultadoNode alloc] initWithResultado:resultado];
    [self addChild:nodeResultado];
    
    //EM SEGUIDA É INSERIDO A PARTE QUE MOSTRA OS VALORES
    nodeValores = [[OperadorValoresNode alloc] initWithValor1:valor1 valor2:valor2];
    [nodeResultado addChild:nodeValores];
    
    //POR FIM É INSERIDO A PARTE QUE MOSTRA O OPERADOR
    nodeOperador = [[OperadorNode alloc] initWithOperador:operador];
    nodeOperador.name = @"operadorNode";
    [nodeOperador setMyDelegate:self];
    [nodeValores addChild:nodeOperador];
    
    [self setUserInteractionEnabled:YES];
    partesVisiveis = NO;
}

//-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    
//    if(clicouCirculo){
//        //É CHAMADA A ANIMAÇÃO DO OPERADOR PRA ELE SE EXPANDIR AO TAMANHO NORMAL
//        [nodeOperador iniciarAnimacaoExpandir];
//        [self iniciarAnimacoes];
//        clicouCirculo = NO;
//    }
//}
//
//
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    UITouch *touch = [touches anyObject];
//    CGPoint position = [touch locationInNode:self];
//    SKNode *node = [self nodeAtPoint:position];
//    
//    if([node.name isEqualToString:@"operador"]){
//        [nodeOperador iniciarAnimacaoDiminuir];
//    }
//}


-(void)iniciarAnimacoes{
    //O METODO VERIFICA QUAIS ANIMAÇÕES SERÃO EXECUTADAS CONFORME O ESTADO ATUAL DOS SPRITES
    //CASO OS SPRITES ESTIVEREM VISIVEIS SERÁ ACIONADO AS ANIMAÇÕES QUE "ESCONDERAM" OS SPRITES E ASSIM POR DIANTE
    
    [self runAction:somOperador];
    [nodeOperador setUserInteractionEnabled:NO];
    
    if(partesVisiveis){
        [self iniciarAnimacaoFechar];
    
    }else{
        [self iniciarAnimacaoAbrir];
    }
    
}

-(void)spriteOperadorClicado{
    [self iniciarAnimacoes];
}


-(void)iniciarAnimacaoAbrir{
    
    [self setUserInteractionEnabled:!self.userInteractionEnabled];
    
    //MANDA O NODE VALORES INICIAR A ANIMAÇÃO DAS LABELS DELE
    [nodeValores iniciarAnimacao];
    //EXECUTA A ANIMAÇÃO DO NODE VALORES QUE EXIBE O NODE
    [nodeValores runAction:[nodeValores getAnimacaoExpandir] completion:^{
        
        //MANDA O NODE RESULTADO INICIAR A ANIMAÇÃO DA LABEL DELE
        [nodeResultado iniciarAnimacao];
        //EXECUTA A ANIMAÇÃO DO NODE RESULTADO QUE EXIBE O NODE
        [nodeResultado runAction:[nodeResultado getAnimacaoDescer] completion:^{
            
            partesVisiveis = !partesVisiveis;
            [self setUserInteractionEnabled:!self.userInteractionEnabled];
            [nodeResultado removeAllActions];
            [nodeValores removeAllActions];
            [nodeOperador setUserInteractionEnabled:self.userInteractionEnabled];
            
            
        }];
    }];

}


-(void)iniciarAnimacaoFechar{
    [self setUserInteractionEnabled:!self.userInteractionEnabled];
    
    //MANDA O NODE RESULTADO INICIAR A ANIMAÇÃO DA LABEL DELE
    [nodeResultado iniciarAnimacao];
    //EXECUTA A ANIMAÇÃO DO NODE RESULTADO QUE ESCONDE O NODE
    [nodeResultado runAction:[nodeResultado getAnimacaoSubir] completion:^{
        
        //MANDA O NODE VALORES INICIAR A ANIMAÇÃO DAS LABELS DELE
        [nodeValores iniciarAnimacao];
        //EXECUTA A ANIMAÇÃO DO NODE VALORES QUE ESCONDE O NODE
        [nodeValores runAction:[nodeValores getAnimacaoDiminuir] completion:^{
            
            partesVisiveis = !partesVisiveis;
            [self setUserInteractionEnabled:!self.userInteractionEnabled];
            [nodeResultado removeAllActions];
            [nodeValores removeAllActions];
            [nodeOperador setUserInteractionEnabled:self.userInteractionEnabled];
            
        }];
    }];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //UITouch *touch = [touches anyObject];
    
//    if (self.myDelegateGesture != nil) {
//        SKScene *cena = (SKScene *)self.myDelegateGesture;
//        
//        CGPoint location = [touch locationInNode:cena];
//        [self setPosition:location];
//    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (self.myDelegateGesture != nil) {
        
        [self.myDelegateGesture terminouGestureOperador:self];
    }
    
    
}


-(void)setLabelValor1:(NSString*)valor1 operador:(NSString*)operador valor2:(NSString*)valor2 resultado:(NSString*)resultado{
    [self setLabelValor1:valor1];
    [self setLabelOperador:operador];
    [self setLabelValor2:valor2];
    [self setLabelResultado:resultado];
}

-(void)setLabelOperador:(NSString*)operador{
    [nodeOperador setLabelOperador:operador];
}

-(void)setLabelValor1:(NSString*)valor1{
    [nodeValores setLabelValor1:valor1];
}

-(void)setLabelValor2:(NSString*)valor2{
    [nodeValores setLabelValor2:valor2];
}

-(void)setLabelResultado:(NSString*)resultado{
    [nodeResultado setLabelResultado:resultado];
}


-(NSString*)getValor1{
    return [nodeValores getValor1];
}

-(NSString*)getOperador{
    return [nodeOperador getOperador];
}

-(NSString*)getValor2{
    return [nodeValores getValor2];
}

-(NSString *)getResultado{
    return [nodeResultado getLabelResultado];
}

-(BOOL)partesVisiveis{
    return partesVisiveis;
}

-(OperadorNode*)retornaOperadorNode{
    return nodeOperador;
}

- (void)criarCorpos{
    
    [nodeOperador criarCorpo];
    [nodeResultado criarCorpo];
}


//- (void)setDonoOperadorNode{
//    [nodeOperador setDono:self];
//}

- (void)pegaMinhaPosicao:(CGPoint)posicao{
    self.position = posicao;
}

-(CGSize)size{
    return CGSizeMake(nodeOperador.size.width, nodeOperador.size.height);
}

@end
