//
//  CenaExercicioVariavel2.m
//  ProjetoFinal
//
//  Created by Henrique Pereira de Lima on 07/08/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "LivreVariavel.h"

@implementation LivreVariavel
{
    NSMutableArray *variaveis;
    SKSpriteNode *botaoCaixa;
    SpriteLabelNode *botaoConteudo;
    SpriteLabelNode *botaoTipo;
    SpriteLabelNode *botaoNome;
    SpriteLabelNode *btnExcluir;
    SKNode *conteudoAtivo;
    int apertei;
    int soltei;
    UITextField *textField;
}

- (id)init{
    self = [super init];
    
    if (self) {
        
        
        variaveis = [NSMutableArray array];
        
        [self criaBotoes];
        
        
        
 
    }
    return self;
}

- (void)limpaTextField{
    
    [textField resignFirstResponder];
    
    textField.text = nil;
    textField.hidden = YES;
}

- (void)excluirNode :(SKNode *) node{
    
    
    
    
    
    
//    [variaveis removeObject:variavel];
//    [variavel remo]
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField*)testando{
    
    [testando resignFirstResponder];
    if ([conteudoAtivo.name isEqualToString:@"label"]) {
        
        SpriteLabelNode *label = (SpriteLabelNode *)conteudoAtivo;
        label.text = textField.text;
        
        [self limpaTextField];
        
        
    }
    
    
    return NO;
    
}

//-(IBAction)userDoneEnteringText:(id)sender
//{
//    UITextField *theField = (UITextField*)sender;
//    // do whatever you want with this text field
//}


-(void)didMoveToView:(SKView *)view{
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGestureRecognizer:)];
    //[longPress setMinimumPressDuration:1.5];
    //[longPress setNumberOfTouchesRequired:2];
    [longPress setNumberOfTouchesRequired:1];
    [longPress setMinimumPressDuration:2];
    [self.view addGestureRecognizer:longPress];
    
    
    
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(self.size.width * 0.6, self.size.height * 0.10, 250, 40)];
    //UITextField *testando = [UITextField alloc]initWithFrame:CGREctM
    //textField.center = self.view.center;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.textColor = [UIColor blackColor];
    textField.font = [UIFont systemFontOfSize:25.0];
    textField.placeholder = @"Enter your name here";
    textField.backgroundColor = [UIColor whiteColor];
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    textField.clearsContextBeforeDrawing = YES;
    textField.delegate = self;
    textField.hidden = YES;
    [self.view addSubview:textField];
    
    
}

- (void)longPressGestureRecognizer:(UILongPressGestureRecognizer *)recognizer{
    
//    if (recognizer.state == UIGestureRecognizerStateBegan) {
//        NSLog(@"gesture comecou");
//    }else if (recognizer.state == UIGestureRecognizerStateChanged){
//        NSLog(@"gesture meio");
//    }else if (recognizer.state == UIGestureRecognizerStateEnded){
//        NSLog(@"gesture fim");
//    }
    
    
    
    if (recognizer.state == UIGestureRecognizerStateBegan && [conteudoAtivo.name isEqualToString:@"caixa"]) {
        NSLog(@"funcionou");
    }else if (recognizer.state == UIGestureRecognizerStateBegan && [conteudoAtivo.name isEqualToString:@"label"]){
        [textField setHidden:NO];
    }
    
    
    
}



- (void)criaBotoes{
    
    
    botaoCaixa = [[SpriteCaixaNode alloc]initWithImageNamed:@"abrir-caixa1.png"];
    //botaoCaixa = [[SpriteCaixaNode alloc]initWithConteudo:@" " nome:@" " tipo:@" " tamanho:CGSizeMake(100, 100)];
    botaoCaixa.position = CGPointMake(100, 100);
    botaoCaixa.size = CGSizeMake(100, 100);
    botaoCaixa.name = @"botaoCaixa";
    [self addChild:botaoCaixa];
    
    
    
    botaoConteudo = [[SpriteLabelNode alloc]initWithType:@"conteudo" texto:@"Cont"];
    botaoConteudo.fontSize = 40;
    botaoConteudo.name = @"botaoConteudo";
    botaoConteudo.position = CGPointMake(250, 80);
    [self addChild:botaoConteudo];
    
    
    botaoTipo = [[SpriteLabelNode alloc]initWithType:@"tipo" texto:@"Tipo"];
    botaoTipo.fontSize = 40;
    botaoTipo.name = @"botaoTipo";
    botaoTipo.position = CGPointMake(430, 80);
    [self addChild:botaoTipo];
    
    
    botaoNome = [[SpriteLabelNode alloc]initWithType:@"nome" texto:@"Nome"];
    botaoNome.fontSize = 40;
    botaoNome.name = @"botaoNome";
    botaoNome.position = CGPointMake(600, 80);
    [self addChild:botaoNome];

    
}

- (void)atualizaCaixa:(SpriteCaixaNode *)caixa Label:(SpriteLabelNode *)label{
    
    
    if ([label.tipo isEqualToString:@"conteudo"]) {
        [caixa setLabelConteudo:label.text];
    }else if ([label.tipo isEqualToString:@"tipo"]){
        [caixa setLabelTipo:label.text];
    }else{
        [caixa setLabelNome:label.text];
    }
    
    [label removeFromParent];
}

- (void)criaVariavel{
    
    SpriteCaixaNode *caixa = [[SpriteCaixaNode alloc]initWithConteudo:@" " nome:@" " tipo:@" " tamanho:CGSizeMake(200, 200)];
    [caixa setPosition:botaoCaixa.position];
    caixa.name = @"caixa";
    [variaveis addObject:caixa];
    [self addChild:caixa];
    
}


- (void)criaConteudo{
    
    SpriteLabelNode *conteudo = [[SpriteLabelNode alloc]initWithType:@"conteudo" texto:@"CONTEUDO"];
    conteudo.fontSize = 60;
    conteudo.name = @"label";
    conteudo.position = botaoConteudo.position;
    [self addChild:conteudo];
    
}

- (void)criarTipo{
    
    SpriteLabelNode *tipo = [[SpriteLabelNode alloc]initWithType:@"tipo" texto:@"TIPO"];
    tipo.fontSize = 60;
    tipo.name = @"label";
    tipo.position = botaoTipo.position;
    [self addChild:tipo];
}

- (void)criarNome{
    
    SpriteLabelNode *nome = [[SpriteLabelNode alloc]initWithType:@"nome" texto:@"NOME"];
    nome.fontSize = 60;
    nome.name = @"label";
    nome.position = botaoNome.position;
    [self addChild:nome];
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //[self textFieldShouldReturn:textField];
    
    [self limpaTextField];
    
    UITouch *touch = [touches anyObject];
    apertei =[touch timestamp];
//    NSLog(@"segurei %d segundos",apertei);
    CGPoint location =  [touch locationInNode:self];
    conteudoAtivo = [self nodeAtPoint:location];
    
        if ([conteudoAtivo.name isEqualToString:@"botaoCaixa"]) {
        
        
        [self criaVariavel];

    }else if ([conteudoAtivo.name isEqualToString:@"botaoConteudo"]){
        
        [self criaConteudo];
        
        
    }else if ([conteudoAtivo.name isEqualToString:@"botaoTipo"]){
        [self criarTipo];
        
    }else if ([conteudoAtivo.name isEqualToString:@"botaoNome"]){
        [self criarNome];
    }else if ([conteudoAtivo.name isEqualToString:@"caixa"] && [touch tapCount] == 2){
        SpriteCaixaNode *c = (SpriteCaixaNode*) conteudoAtivo;
        [c executaSprite];
    }
    
    
    
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    if ([conteudoAtivo.name isEqualToString:@"caixa"] || [conteudoAtivo.name isEqualToString:@"label"]) {
        conteudoAtivo.position = location;
    }else{
        conteudoAtivo = nil;
    }
    
    
    //SE A POSIÇÃO QUE FOI CLICADA É A MESMA DO SPRITE DA CAIXA, O SPRITE É MOVIDO
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if ([conteudoAtivo.name isEqualToString:@"label"] && variaveis.count > 0) {
        
        
        for (SpriteCaixaNode * c in variaveis) { //Ao soltar o node de resposta em algum lugar varre o vetor de caixas para descobrir sobre quem está
            float xInicio = c.frame.origin.x;
            float xFim = xInicio + c.frame.size.width;
            //float xMeio = (xInicio + xFim)/2; PARA O FUTURO
            float yInicio = c.frame.origin.y;
            float yFim = yInicio + c.frame.size.height;
            //float yMeio = (yInicio + yFim)/2; PARA O FUTURO
            
            if ((conteudoAtivo.position.x > xInicio && conteudoAtivo.position.x < xFim)&&(conteudoAtivo.position.y >yInicio && conteudoAtivo.position.y < yFim)) { // Verifica se o nó "resposta" está sobre alguma caixa
                NSLog(@"deu certo");
                [self atualizaCaixa:c Label:(SpriteLabelNode *) conteudoAtivo];
            }
                
                //[conteudoAtivo setPosition:CGPointMake(xMeio, yMeio)]; //Coloca o node no centro da caixa
        }
            
    }
        
    
    
    
}

@end
