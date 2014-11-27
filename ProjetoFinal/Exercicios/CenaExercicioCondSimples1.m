//
//  CenaExercicioCondSimples1.m
//  ProjetoFinal
//
//  Created by Henrique Pereira de Lima on 21/07/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "CenaExercicioCondSimples1.h"
#import <stdlib.h>

@implementation CenaExercicioCondSimples1
{
    NSMutableArray *expressoes;
    NSMutableArray *alternativas;
    SKSpriteNode *espaco;
    SKSpriteNode *breakpoint;
    SKLabelNode *debugar;
    SpriteLabelNode *alternativaMarcada;
    NSString *condicaoCerta;
    Geral *calculador;
    float font;
    int n;
    int indice;
    BOOL jaApareceu;
    BOOL habilitarDebugar;
    BOOL jaRespondeu;
    CGPoint posicaoBreakPoint;
    
}




//metodos utilizado para criacao

- (id)init{
    
    self = [super init];
    
    if (self) {
        self.backgroundColor = [SKColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
        
        font = self.frame.size.height * 25;
        calculador = [[Geral alloc]init];
        
        
        [self criaEnunciado];
        [self criaExpressoes];
        [self criaAlternativas];
        
        //cria espaco onde as condicoes serao movidas
        
        espaco = [SKSpriteNode spriteNodeWithImageNamed:@"fundo-cinza.png"];
        espaco.size = CGSizeMake(150, 100);
        espaco.position = CGPointMake(600, 100);
        espaco.zPosition = -1;
        posicaoBreakPoint.x = 500;
        
        [self addChild:espaco];
        
        
        //prepara botao para obter resposta
        
        SKLabelNode *botao = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
        botao.text = @"Botao Resposta";
        botao.name = @"botaoResposta";
        botao.fontSize = 30;
        botao.position = CGPointMake(550, 500);
        
        [self addChild:botao];

        
        
        [self preparaAnimacao];
        
        
        
        
    }
    return self;
    
    
}

- (void)criaEnunciado{
    
    
    
    NSString *texto1 = @"Assinale a alternativa Correta.";
    NSString *texto2 = @"O que será escrito na tela, segundo as seguintes instruções:";
    
    
    
    //Criando Label 1
    
    SKLabelNode *lblEnunciado1 = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    [lblEnunciado1 setText:texto1];
    lblEnunciado1.position = CGPointMake(self.frame.size.width * 230, self.frame.size.height * 900);
    lblEnunciado1.fontSize = font;
    [self addChild:lblEnunciado1];
    
    
    //Criando Label 2
    
    
    SKLabelNode *lblEnunciado2 = [SKLabelNode labelNodeWithFontNamed:@"Arial"];
    [lblEnunciado2 setText:texto2];
    lblEnunciado2.position = CGPointMake(self.frame.size.width * 400, self.frame.size.height * 850);
    lblEnunciado2.fontSize = font;
    [self addChild:lblEnunciado2];
    
    
}

- (void)criarBotaoFinalizar{
    
    //CRIA BOTAO PARA VOLTAR A LISTA DE EXERCICIOS
    
    
    SKLabelNode *finalizar = [[SKLabelNode alloc]init];
    finalizar.text = @"Finalizar";
    finalizar.position = CGPointMake(450, 250);
    finalizar.fontSize = 70;
    [finalizar setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    finalizar.name = @"botaoFinalizar";
    
    [self addChild:finalizar];
    
    
    
}




- (void)criaExpressoes{
    
    SKLabelNode *lblCodigo1;
    SpriteLabelNode *condicao;
    expressoes = [NSMutableArray array];
    float altura = self.frame.size.height * 770;
    
    
    //linha 1
    
    //editando texto
    n = arc4random() % 10;
    lblCodigo1 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    lblCodigo1.text = [NSString stringWithFormat:@"n <- %d",n];
    lblCodigo1.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    
    condicao = [[SpriteLabelNode alloc]init];
    
    //editando tamanho e posicao
    
    lblCodigo1.position = CGPointMake(self.frame.size.width * 50, altura);
    condicao.position = lblCodigo1.position;
    condicao.name = @"nula";
    lblCodigo1.fontSize = font;
    
    //salvando e aadicionado linha
    [self salvaExpressoes:condicao texto:lblCodigo1];
    [self addChild:lblCodigo1];
    condicao = nil;
    altura -= 40;
    
    
    //linha 2
    
    //editando texto
    
    lblCodigo1 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    lblCodigo1.text = @"se(          )";
    lblCodigo1.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    
    condicao = [[SpriteLabelNode alloc]initWithType:@"se1" texto:@"n < 3"];
    condicao.fontName = @"Helvetica";
    condicao.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    condicao.name = @"condicao";
    
    //editando posicao
    
    lblCodigo1.position = CGPointMake(self.frame.size.width * 50, altura);;
    lblCodigo1.fontSize = font;
    NSLog(@"tamanho tela %f",self.frame.size.width * 50);
    
    condicao.position = CGPointMake(self.frame.size.width * 90, altura);
    condicao.posicaoInicial = condicao.position;
    condicao.fontSize = font;
    
    //adicionando e salvando linha
    [self salvaExpressoes:condicao texto:lblCodigo1];
    [self addChild:lblCodigo1];
    [self addChild:condicao];
    
    //preparando para proxima linha
    lblCodigo1 = nil;
    condicao = nil;
    altura -= 40;
    
    
    //linha 3
    
    lblCodigo1 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    lblCodigo1.text = @"escreva (vou ao parque)";
    lblCodigo1.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    
    condicao = [[SpriteLabelNode alloc]init];
    
    //editando posicionamento e font
    
    lblCodigo1.position = CGPointMake(self.frame.size.width * 80, altura);;
    lblCodigo1.fontSize = font;
    condicao.position = lblCodigo1.position;
    condicao.name = @"linha";
    condicao.tipo = @"se1";
    
    //salvando e adicionando linha
    
    [self salvaExpressoes:condicao texto:lblCodigo1];
    [self addChild:lblCodigo1];
    altura -= 40;
    
    //linha 4
    
    //editando texto
    
    lblCodigo1 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    lblCodigo1.text = @"senao se (          )";
    lblCodigo1.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    
    condicao = [[SpriteLabelNode alloc]initWithType:@"se2" texto:@"n < 6"];
    condicao.fontName = @"Helvetica";
    condicao.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    condicao.name = @"condicao";
    
    //editando posicionamento e font
    
    lblCodigo1.position = CGPointMake(self.frame.size.width * 50, altura);;
    lblCodigo1.fontSize = font;
    
    condicao.position = CGPointMake(self.frame.size.width * 180, altura);
    condicao.posicaoInicial = condicao.position;
    condicao.fontSize = font;
    
    //salvando e adicionando linha
    
    [self salvaExpressoes:condicao texto:lblCodigo1];
    [self addChild:lblCodigo1];
    [self addChild:condicao];
    altura -= 40;
    
    //linha 5
    
    
    lblCodigo1 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    lblCodigo1.text = @"escreva (vou para o cinema)";
    lblCodigo1.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    
    condicao = [[SpriteLabelNode alloc]init];
    
    //editando posicionamento e font
    
    lblCodigo1.position = CGPointMake(self.frame.size.width * 80, altura);
    condicao.position = lblCodigo1.position;
    condicao.name = @"linha";
    condicao.tipo = @"se2";
    lblCodigo1.fontSize = font;
    
    
    //salvando e adicionando linha
    
    [self salvaExpressoes:condicao texto:lblCodigo1];
    [self addChild:lblCodigo1];
    altura -= 40;
    
    
    //linha 6
    
    //editando texto
    
    lblCodigo1 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    lblCodigo1.text = @"senao";
    lblCodigo1.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    
    condicao = [[SpriteLabelNode alloc]init];
    
    
    //editando posicionamento e font
    
    lblCodigo1.position = CGPointMake(self.frame.size.width * 50, altura);
    condicao.position = lblCodigo1.position;
    condicao.name = @"senao";
    lblCodigo1.fontSize = font;
    
    
    //salvando e adicionando linha
    
    [self salvaExpressoes:condicao texto:lblCodigo1];
    [self addChild:lblCodigo1];
    altura -= 40;
    
    
    
    //linha 7
    
    lblCodigo1 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    lblCodigo1.text = @"escreva(ficarei em casa)";
    lblCodigo1.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    
    condicao = [[SpriteLabelNode alloc]init];
    
    //editando posicionamento e font
    
    lblCodigo1.position = CGPointMake(self.frame.size.width * 80, altura);
    condicao.position = lblCodigo1.position;
    condicao.name = @"linha";
    condicao.tipo = @"senao";
    lblCodigo1.fontSize = font;
    
    
    //salvando e adicionando linha
    
    [self salvaExpressoes:condicao texto:lblCodigo1];
    [self addChild:lblCodigo1];
    altura -= 40;
    
    //linha 8
    
    lblCodigo1 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    lblCodigo1.text = @"fimse";
    lblCodigo1.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    
    condicao = [[SpriteLabelNode alloc]init];
    
    
    //editando posicionamento e font
    
    lblCodigo1.position = CGPointMake(self.frame.size.width * 50, altura);
    condicao.position = lblCodigo1.position;
    condicao.name = @"nula";
    lblCodigo1.fontSize = font;
    
    
    //salvando e adicionando linha
    
    [self salvaExpressoes:condicao texto:lblCodigo1];
    [self addChild:lblCodigo1];
    altura -= 40;
    
    
    
}

-(void)salvaExpressoes:(SpriteLabelNode*)condicao texto:(SKLabelNode *)texto{
    
    NSDictionary *linha = @{
                            @"condicao":condicao,
                            @"texto":texto
                            };
    
    [expressoes addObject:linha];
}

- (void)criaAlternativas{
    
    int fontAlternativas = self.frame.size.height * 35;
    
    alternativas = [NSMutableArray array];
    
    CGPoint posiciaoInicial = CGPointMake(self.frame.size.width * 70, self.frame.size.height * 300);
    CGPoint posicaoMutavel = posiciaoInicial;
    
    NSMutableArray *textos = [NSMutableArray array];
    NSMutableArray *tipos = [NSMutableArray array];
    NSMutableArray *tiposETextos = [NSMutableArray array];
    
    //textos das alternativas
    [textos addObject:@"vou ao parque"];
    [textos addObject:@"vou para o cinema"];
    [textos addObject:@"ficarei em casa"];
    [textos addObject:@"todas alternativas"];
    
    [tipos addObject:@"se1"];
    [tipos addObject:@"se2"];
    [tipos addObject:@"senao"];
    [tipos addObject:@"errada"];
    
    
    for (int i =0; i < textos.count; i++) {
        NSDictionary *dict = @{
                               @"tipo":[tipos objectAtIndex:i],
                               @"texto":[textos objectAtIndex:i]
                               };
        [tiposETextos addObject:dict];
    }
    
    tiposETextos = [self embaralha:tiposETextos];
    
    
    
    //criando alternativas
    
    SpriteLabelNode *alternativaA = [[SpriteLabelNode alloc]initWithType:[[tiposETextos objectAtIndex:0] objectForKey:@"tipo"] texto:[NSString stringWithFormat:@"a. %@",[[tiposETextos objectAtIndex:0] objectForKey:@"texto"] ]];
    
    SpriteLabelNode *alternativaB = [[SpriteLabelNode alloc]initWithType:[[tiposETextos objectAtIndex:1] objectForKey:@"tipo"] texto:[NSString stringWithFormat:@"b. %@",[[tiposETextos objectAtIndex:1] objectForKey:@"texto"] ]];
    
    SpriteLabelNode *alternativaC = [[SpriteLabelNode alloc]initWithType:[[tiposETextos objectAtIndex:2] objectForKey:@"tipo"] texto:[NSString stringWithFormat:@"c. %@",[[tiposETextos objectAtIndex:2] objectForKey:@"texto"] ]];
    
    SpriteLabelNode *alternativaD = [[SpriteLabelNode alloc]initWithType:[[tiposETextos objectAtIndex:3] objectForKey:@"tipo"] texto:[NSString stringWithFormat:@"d. %@",[[tiposETextos objectAtIndex:3] objectForKey:@"texto"] ]];
    
    
    //inserindo no vetor
    
    [alternativas addObject:alternativaA];
    [alternativas addObject:alternativaB];
    [alternativas addObject:alternativaC];
    [alternativas addObject:alternativaD];
    
    
    
    for (SKLabelNode *aux in alternativas) {
        aux.fontSize = fontAlternativas;
        aux.position = posicaoMutavel;
        aux.fontName = @"Arial";
        aux.name = @"alternativa";
        aux.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        posicaoMutavel.y -= 60;
        [self addChild:aux];
    }
    
    
    
}

-(void)criaBotaoDebugar{
    
    
    //botaao debugar
    
    if (debugar != nil) {
        return;
    }
    
    debugar = [[SKLabelNode alloc] initWithFontNamed:@"Chalkduster"];
    debugar.text = @"Debugar";
    debugar.name = @"debugar";
    debugar.fontSize = 30;
    debugar.position = CGPointMake(550, 400);
    habilitarDebugar = YES;
    
    [self addChild:debugar];
    
}



//metodos para animacao


- (void)preparaAnimacao{
    
    breakpoint = [SKSpriteNode spriteNodeWithImageNamed:@"fundo-cinza.png"];
    breakpoint.size = CGSizeMake(1000, 35);
    indice = 0;
    breakpoint.zPosition = -1;
    //breakpoint.position = CGPointMake(500, 770);
    //[self addChild:breakpoint];
    
}

-(void)resetaBreakPoint{
    
    indice = 0;
    [breakpoint removeFromParent];
    jaApareceu = NO;
    condicaoCerta = nil;
    habilitarDebugar = YES;
    
    
}


- (NSString *)calculaOperacao:(NSString *)operacao{
    
    //pega os caracteres da condicao e jogam no vetor *charArray tirando todos os espacos
    
    NSMutableArray *caracteres = [self converteCondicaoTexto:operacao];
    //caracteres do vetor *charArray sao passados para o calculador retornar o resultado da expressao
    
    return [calculador calculaOperador:[caracteres objectAtIndex:1] numero1:[caracteres objectAtIndex:0] numero2:[caracteres objectAtIndex:2]];
    
}

- (void)debugar{
    
    
    //cria variaveis necessarias
    
    BOOL habilitaMoveBreakPoint = NO; //habilitará a animacao do breakPoint
    BOOL habilitaMoveCondicao = NO; //habilitará a animacao de mover a condicao
    NSString *resultado;
    

    
    if (indice >= expressoes.count) {
        
        //acabou a animacao sera preciso reseta-la
        
        [self resetaBreakPoint];
        
        
    }else{
        
        
            
            //pega condicao do vetor de expressoes
            
            SpriteLabelNode *condicao = [[expressoes objectAtIndex:indice] objectForKey:@"condicao"];
            NSLog(@"name %@  tipo %@",condicao.name,condicao.tipo);
        
        
            // verifica se ja apareceu a condicao verdadeira
            
            if (condicaoCerta != nil) {
                
                // entrada no IF caso o breakPoint nao puder se mover a esta linha, pois ja foi descoberta a condicao verdadeira
                
                if (([condicao.name isEqualToString:@"linha"] && ![condicao.tipo isEqualToString:condicaoCerta]) || [condicao.name isEqualToString:@"condicao"] || [condicao.name isEqualToString:@"senao"]) {
                    
                    //acha a proxima linha que o breakPoint pode passar
                    
                    while (![condicao.name isEqualToString:@"nula"] && indice < expressoes.count) {
                        condicao = [[expressoes objectAtIndex:indice] objectForKey:@"condicao"];
                        NSLog(@"name %@  tipo %@",condicao.name,condicao.tipo);
                        indice++;
                    }
                    
                }
                
                // aqui a condicao verdadeira ainda nao foi achada
                
                // esse IF nao deixa o breakPoint se mover para a linha de uma condicional falsa
                
            }else if ([condicao.name isEqualToString:@"linha"] && ![condicao.tipo isEqualToString:@"senao"]){
                
                // acha a proxima linha que o breakPoint deve se mover
                while (![condicao.name isEqualToString:@"nula"] && ![condicao.name isEqualToString:@"condicao"] && ![condicao.name isEqualToString:@"senao"] && indice < expressoes.count) {
                    indice++;
                    condicao = [[expressoes objectAtIndex:indice] objectForKey:@"condicao"];
                    NSLog(@"name %@  tipo %@",condicao.name,condicao.tipo);
                }
                
                
                
            }
            
            
            //configura posicao break point
            posicaoBreakPoint.y = condicao.position.y;
            breakpoint.position = posicaoBreakPoint;
            
            
            //verifica se o breakpoint ja esta na tela
            if (!jaApareceu) {
                [self addChild:breakpoint];
                jaApareceu = YES;
                habilitarDebugar = YES;
            }else{
                
                //habilita a animacao do BreakPoint
                habilitaMoveBreakPoint = YES;
                
                    
                    //
                    
                    if ([condicao.name isEqualToString:@"condicao"]) {
                        
                        //se a condicao for diferente de nula a cor da label e posicao sao alterados
                        condicao.fontColor = [SKColor yellowColor];
                        
                        //habilita animacao de mover a Condicao
                        habilitaMoveCondicao = YES;
                        
                        //faz o calculo da condicao recebendo um verdadeiro ou falso
                        resultado = [self calculaOperacao:condicao.text];
                        
                        
                        
                    }
                
                //Animacao
                
                
                //faz animacao BreakPoint se habilitado
                
                if (habilitaMoveBreakPoint) {
                    [self runAction:[SKAction waitForDuration:1]];
                    [breakpoint runAction:[SKAction moveToY:posicaoBreakPoint.y duration:1]];
                    habilitarDebugar = YES;
                }
                
                //faz animacao Condicao se habilitado
                
                if (habilitaMoveCondicao) {
                    [self runAction:[SKAction waitForDuration:1]];
                    [condicao runAction:[SKAction moveTo:espaco.position duration:2]];
                    
                    
                    
                    [self runAction:[SKAction waitForDuration:4] completion:^{
                        if ([resultado isEqualToString:@"Verdadeiro"]) {
                            condicao.fontColor = [SKColor greenColor];
                            condicaoCerta = condicao.tipo;
                        }else{
                            condicao.fontColor = [SKColor redColor];
                        }
                        [condicao runAction:[SKAction moveTo:condicao.posicaoInicial duration:3]];
                        
                    }];
                    
                    
                }


                
            }

            indice++;
        
    }
    
}


//demais metodos

-(NSMutableArray *)converteCondicaoTexto :(NSString *)texto{
    
    NSMutableArray *charArray = [NSMutableArray arrayWithCapacity:texto.length];
    for (int i=0; i<texto.length; ++i) {
        NSString *charStr = [texto substringWithRange:NSMakeRange(i, 1)];
        
        
        if ([charStr isEqualToString:@"n"]) {
            [charArray addObject:[NSString stringWithFormat:@"%d",n]];
        }else if (![charStr isEqualToString:@" "]){
            [charArray addObject:charStr];
        }
        
        
        
        
    }

    return charArray;
    
}

-(void)corrigeExercicio{
    //n = 7;
    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"ExeVariavel1"];
    NSMutableArray *caracteres;
    
    for (NSDictionary *linha in expressoes) {
        SpriteLabelNode *condicao = [linha objectForKey:@"condicao"];
        
        
        //verifica se a condicao existe
        NSLog(@"condicao == %@",condicao.name);
        if (![condicao.name isEqualToString:@"nula"] && ![condicao.name isEqualToString:@"senao"] && ![condicao.name isEqualToString:@"linha"]) {
            caracteres = [self converteCondicaoTexto:condicao.text];
            
            
            //chamando interpretador para devolver o resultado da condicao
            NSString *resultado = [calculador calculaOperador:[caracteres objectAtIndex:1] numero1:[caracteres objectAtIndex:0] numero2:[caracteres objectAtIndex:2]];
            
            
            
            if ([resultado isEqualToString:@"Verdadeiro"]) {
                resultado = condicao.tipo;
                
                
                for (SpriteLabelNode *alternativaCorreta in alternativas) {
                    if ([resultado isEqualToString:alternativaCorreta.tipo]) {
                        
                        alternativaCorreta.fontColor = [SKColor greenColor];
                        
                        
                        if (alternativaCorreta != alternativaMarcada) {
                            alternativaMarcada.fontColor = [SKColor redColor];
                        }
                        
                        return;
                    }
                }
                
                
                
                
            }
            
        }
        
        
        
        
    }
    for (SpriteLabelNode *alternativaCorreta in alternativas) {
        if ([alternativaCorreta.tipo isEqualToString:@"senao"]) {
            alternativaCorreta.fontColor = [SKColor greenColor];
            if (alternativaCorreta != alternativaMarcada) {
                alternativaMarcada.fontColor = [SKColor redColor];
            }
            
            
            break;
        }
    }
    
    
}

- (NSMutableArray *)embaralha :(NSMutableArray *)antigo{
    
    int n1;
    NSMutableArray *vetorEmbaralhado = [NSMutableArray array];
    
    while (antigo.count > 0) {
        n1 = arc4random() % antigo.count;
        
        [vetorEmbaralhado addObject:[antigo objectAtIndex:n1]];
        [antigo removeObjectAtIndex:n1];
    }
    
    
    
    
    return vetorEmbaralhado;
    
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *nodeClicado = [self nodeAtPoint:location];
    
    if ([touch tapCount] > 1) {
        return;
    }
    
    
    if ([nodeClicado.name isEqualToString:@"alternativa"] && !jaRespondeu) {
        
        if (alternativaMarcada != nil) {
            alternativaMarcada.fontColor = [SKColor whiteColor];
        }
        SpriteLabelNode *aux = (SpriteLabelNode *) [self nodeAtPoint:location];
        alternativaMarcada = aux;
        alternativaMarcada.fontColor = [SKColor yellowColor];
        
    }else if ([nodeClicado.name isEqualToString:@"botaoResposta"] && alternativaMarcada != nil && !jaRespondeu){
        if (debugar == nil) {
            [self criaBotaoDebugar];
            jaRespondeu = YES;
            [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"ExeCondSimples1"];
            [self criarBotaoFinalizar];
        }
        [self corrigeExercicio];
    }else if ([nodeClicado.name isEqualToString:@"debugar"] && habilitarDebugar){
        habilitarDebugar = NO;
        //NSLog(@"DEBUGOU");
        [self debugar];
    }else if ([nodeClicado.name isEqualToString:@"botaoFinalizar"]){
        [self.myDelegate exercicioFinalizado];
    }

    
}


@end
