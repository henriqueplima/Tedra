//
//  CenaExercicioVariavel2.m
//  ProjetoFinal
//
//  Created by Henrique Pereira de Lima on 12/08/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "CenaExercicioVariavel2.h"

@implementation CenaExercicioVariavel2{
    SpriteCaixaNode *variavel;
    SKNode *conteudoAtivo;
    UITextField *textField;
    NSMutableArray *resposta;
    SKLabelNode *trechoEmPortugol;
    SKLabelNode *controlePasso;
    SKLabelNode *mensagemErro;
    SpriteLabelNode *labelCriada;
    int etapa;
}

- (id)init{
    self = [super init];
    
    if (self) {
        
        [self criaVariavel];
        [self criaBotoes];
        [self criaEnunciado];
        self.backgroundColor = [SKColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1.0];
        [self reinicializaExercicio];
        
    }
    return self;
}

-(void)didMoveToView:(SKView *)view{
    
    //CRIA O GESTURE E A TEXT FIELD
    
    //GESTURE
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGestureRecognizer:)];
    //[longPress setMinimumPressDuration:1.5];
    //[longPress setNumberOfTouchesRequired:2];
    [longPress setNumberOfTouchesRequired:1];
    [longPress setMinimumPressDuration:1];
    [self.view addGestureRecognizer:longPress];
    
    //TEXT FIELD
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(self.size.width * 0.6, self.size.height * 0.30, 250, 40)];
    //UITextField *testando = [UITextField alloc]initWithFrame:CGREctM
    //textField.center = self.view.center;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.textColor = [UIColor blackColor];
    textField.font = [UIFont systemFontOfSize:25.0];
    textField.placeholder = @"Insira o valor";
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

-(void)criaMensagemErro{
    
    //CRIA MENSAGEM DE ERRO E SOM DE ERRO
    
    mensagemErro = [[SKLabelNode alloc]init];
    mensagemErro.position = CGPointMake(70, 750);
    [mensagemErro setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    mensagemErro.text = @"Existe algo errado na variável";
    mensagemErro.fontColor = [SKColor redColor];
    
    [self addChild:mensagemErro];
    [self runAction:[SKAction playSoundFileNamed:@"errado.wav" waitForCompletion:NO]];
}

- (void)criarBotaoFinalizar{
    
    //CRIA BOTAO PARA VOLTAR A LISTA DE EXERCICIOS
    
    
    SKLabelNode *finalizar = [[SKLabelNode alloc]init];
    finalizar.text = @"Finalizar";
    finalizar.position = CGPointMake(400, 200);
    finalizar.fontSize = 70;
    [finalizar setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    finalizar.name = @"botaoFinalizar";
    
    [self addChild:finalizar];
    
    
    
}


- (void)criandoLabelEtapa{
    
    //ESSE METODO CRIA A LABEL QUE MOSTRA EM QUAL PASSO DO EXERCICO ELE SE ENCONTRA
    
    
    controlePasso = [[SKLabelNode alloc]initWithFontNamed:@"Helvetica"];
    NSLog(@"criando label %d",etapa);
    controlePasso.text = [NSString stringWithFormat:@"%d/3",etapa];
    
    controlePasso.position = CGPointMake(700, 500);
    
    [self addChild:controlePasso];
    
}

- (void)criaEnunciado{
    
    //CRIA ENUNCIADO DO EXERCICIO
    
    SKLabelNode *enunciado = [[SKLabelNode alloc]init];
    enunciado.text = @"Monte as variáveis conforme o trecho a seguir:";
    enunciado.position = CGPointMake(50, 900);
    [enunciado setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    
    [self addChild:enunciado];
    
    
    
}

- (void)criaTrechoEmPortugol{
    
    
    
    
    if (etapa > 3) {
        NSLog(@"acabou");
        return;
    }
    
    resposta = [[NSMutableArray alloc]init];
    Gerador *gerador = [[Gerador alloc]init];
    
    for (int i = 0; i < 4; i++) {
        [resposta addObject:[self retornaTextoIndice:i Gerador:gerador]];
    }
    
    
    
    trechoEmPortugol = [[SKLabelNode alloc] initWithFontNamed:@"Helvetica"];
    trechoEmPortugol.fontSize = 40;
    trechoEmPortugol.text = [resposta componentsJoinedByString:@" "];
    trechoEmPortugol.position = CGPointMake(50, 800);
    trechoEmPortugol.fontColor = [SKColor yellowColor];
    [trechoEmPortugol setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    NSLog(@"vai incrementar %d" ,etapa);
    
    NSLog(@"ja incrementou %d",etapa);
    [self addChild:trechoEmPortugol];
    
    
    
    
}

- (void)criaBotoes{
    
    //CRIA BOTOES PARA CRIAR AS LABELS QUE SERAO INSERIDAS NA CAIXA
    
    float font = 40;
    
    //BOTAO TIPO
    
    SpriteLabelNode *botaoTipo = [[SpriteLabelNode alloc]initWithType:@"TIPO" texto:@"Tipo"];
    botaoTipo.fontSize = font;
    botaoTipo.name = @"botaoLabel";
    botaoTipo.position = CGPointMake(100, 80);
    [botaoTipo setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    [self addChild:botaoTipo];
    
    
    //BOTAO NOME
    
    
    SpriteLabelNode *botaoNome = [[SpriteLabelNode alloc]initWithType:@"NOME" texto:@"Nome"];
    botaoNome.fontSize = font;
    botaoNome.name = @"botaoLabel";
    botaoNome.position = CGPointMake(botaoTipo.position.x + 200, 80);
    [botaoNome setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    [self addChild:botaoNome];
    
    //BOTAO CONTEUDO
    
    SpriteLabelNode *botaoConteudo = [[SpriteLabelNode alloc]initWithType:@"CONTEUDO" texto:@"Conteudo"];
    botaoConteudo.fontSize = font;
    botaoConteudo.name = @"botaoLabel";
    botaoConteudo.position = CGPointMake(botaoNome.position.x + 300, 80);
    [botaoNome setHorizontalAlignmentMode:SKLabelHorizontalAlignmentModeLeft];
    [self addChild:botaoConteudo];
    
    
    
}


- (void)criaVariavel{
    
    //CRIA VARIAVEL (CAIXA)
    
    variavel = [[SpriteCaixaNode alloc]init];
    [variavel setPosition:CGPointMake(400  , 500)];
    
    variavel.name = @"caixa";
    [variavel iniciarAnimacaoIntroducao];
    [self addChild:variavel];
    
}

- (void)criaLabelTipo : (NSString*)tipo{
    
    
    //CRIA LABELS  QUE SERAO INSERIDAS NA VARIAVEL
    
    
    labelCriada = [[SpriteLabelNode alloc]initWithType:tipo texto:tipo];
    labelCriada.fontSize = 60;
    labelCriada.name = @"label";
    labelCriada.position = CGPointMake(400, 200);
    labelCriada.posicaoInicial = labelCriada.position;
    [self addChild:labelCriada];
    conteudoAtivo = labelCriada;
    
}

- (NSString *)retornaTextoIndice :(int)i Gerador:(Gerador *)gerador{
    
    
    
    switch (i) {
        case 0:
            return [gerador retornaTipoVariavel];
            break;
            
        case 1:
            return [gerador retornaNomeVariavel:[resposta objectAtIndex:i-i]];
            break;
            
            
        case 2:
            return @"<-";
            break;
            
        case 3:
            
            if ([[resposta objectAtIndex:i-i]isEqualToString:@"inteiro"]) {
                
                
                return [gerador retornaValorInteiro:1 ate:100];
            }else if ([[resposta objectAtIndex:i-i]isEqualToString:@"real"]){
                
                
                return [gerador retornaValorFloat:1 ate:1000];
                
                
            }else if ([[resposta objectAtIndex:i-i]isEqualToString:@"caractere"]){
                
                return [gerador retornaValorCaractere];
                
            }else{
                return [gerador retornaValorLogico];
            }
            
            break;
        default:
            
            return nil;
            break;
    }
    
    
    
}


- (void)longPressGestureRecognizer:(UILongPressGestureRecognizer *)recognizer{
    
    //RECONHECE O GESTURE DE LONGPRESS
    
    
    if (recognizer.state == UIGestureRecognizerStateBegan && [conteudoAtivo.name isEqualToString:@"label"]){
        
        //HABILITA A TEXTFIELD
        [textField setHidden:NO];
    }
    
    
    
}

- (void)atualizaCaixa:(SpriteCaixaNode *)caixa Label:(SpriteLabelNode *)label{
    
    //INSERE O TEXTO DAS LABELS NA CAIXA
    
    
    if ([label.tipo isEqualToString:@"CONTEUDO"]) {
        [caixa setLabelConteudo:label.text];
        labelCriada = nil;
        [label removeFromParent];
        
    }else if ([label.tipo isEqualToString:@"TIPO"] && [self tipoCorreto:label.text]){
        [caixa setLabelTipo:label.text];
        labelCriada = nil;
        [label removeFromParent];
    }else if ([label.tipo isEqualToString:@"NOME"]){
        [caixa setLabelNome:label.text];
        labelCriada = nil;
        [label removeFromParent];
        
    }else{
        [labelCriada runAction:[SKAction moveTo:labelCriada.posicaoInicial duration:1]] ;
    }
    
    
    
}

- (BOOL)tipoCorreto : (NSString *)texto{
    
    //VERIFICA SE O TIPO DA LABEL FOR TIPO ENTAO VERIFICA SE O USUARIO DIGITOU UM DOS QUATROS TIPOS DE VARIAVEIS
    
    if (![texto isEqualToString:@"caractere"] && ![texto isEqualToString:@"inteiro"] && ![texto isEqualToString:@"real"] && ![texto isEqualToString:@"logico"]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERRO"
                                                        message:@"TIPO DE VARIAVEL INEXISTENTE"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [self runAction:[SKAction playSoundFileNamed:@"errado.wav" waitForCompletion:NO]];
        [alert show];
        
        
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField*)testando{
    
    //METODO DE RETORNO DA TEXTFIELD
    
    [testando resignFirstResponder];
    
    //VERIFICA SE O CONTEUDO ATIVO SE CHAMA LABEL
    if ([conteudoAtivo.name isEqualToString:@"label"]) {
        
        SpriteLabelNode *label = (SpriteLabelNode *)conteudoAtivo;
        
        if ([label.tipo isEqualToString:@"TIPO"]) {
            
            
            
            if (![self tipoCorreto:textField.text]) {
                
                //SENAO FOR ELE GERA UM ALERTA
                
                
                return YES;
            }
            
            
        }
        //CASO ESTIVER CERTO ELE INSERE O TEXTO NA LABEL
        
        label.text = textField.text;
        
        [self limpaTextField];
        
        
    }
    
    
    return NO;
    
}


- (void)limpaTextField{
    
    //LIMPA A TEXTFIELD
    
    [textField resignFirstResponder];
    
    textField.text = nil;
    textField.hidden = YES;
}

- (void)reinicializaExercicio{
    //ESSE METODO INICIA E REINICIALIZA O EXERCICIO
    
    etapa++; //INCREMENTA O PASSO (ETAPA)
    
    //REMOVE A IMAGEM DA CENA
    
    [mensagemErro removeFromParent];
    mensagemErro = nil;
    
    
    
    if (etapa > 3) {
        
        //ACABOU O EXERCICIO
        
        //CRIA LABEL PARABENS
        
        SKLabelNode *parabens = [[SKLabelNode alloc]init];
        parabens.text = @"Parabéns";
        parabens.position = variavel.position;
        parabens.fontSize = 90;
        [variavel removeFromParent];
        [self addChild:parabens];
        
        //PASSA YES PARA O USERDEFAULTS
        
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"ExeVariavel2"];
        [self criarBotaoFinalizar];
        
        return;
    }
    
    //RETIRA NODES VELHOS E CRIA NOVOS
    
    [variavel removeFromParent];
    [trechoEmPortugol removeFromParent];
    [controlePasso removeFromParent];
    [self criaTrechoEmPortugol];
    [self criaVariavel];
    [self criandoLabelEtapa];
    
    
}

- (void)corrigirExercicio{
    
    //SEPARA AS STRINGS DO VETOR DE RESPOSTA
    
    NSString *tipo = [resposta objectAtIndex:0];
    NSString *nome = [resposta objectAtIndex:1];
    NSString *conteudo = [resposta objectAtIndex:3];
    
    //VERIFICA SE OS TEXOTS DAS LABELS DA CAIXA SAO IGUAIS AS RESPOSTAS
    
    if ([[variavel retornaTipo] isEqualToString:tipo] && [[variavel retornaNome] isEqualToString:nome] && [[variavel retornaConteudo] isEqualToString:conteudo]) {
        
        
        [self runAction:[SKAction playSoundFileNamed:@"correto.aiff" waitForCompletion:NO]];
        [self reinicializaExercicio];
        
        
        //NSLog(@"inicia novamente");
        
    }else{
        [self criaMensagemErro];
        //NSLog(@"errada");
    }
    
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //[self textFieldShouldReturn:textField];
    
    [self limpaTextField];
    
    UITouch *touch = [touches anyObject];
    CGPoint location =  [touch locationInNode:self];
    conteudoAtivo = [self nodeAtPoint:location];
    
    if ([conteudoAtivo.name isEqualToString:@"botaoLabel"] && labelCriada == nil) {
        
        SpriteLabelNode *aux = (SpriteLabelNode *)conteudoAtivo;
        
        
        [self criaLabelTipo:aux.tipo];
        [textField setHidden:NO];
        
        
    }else if ([conteudoAtivo.name isEqualToString:@"botaoFinalizar"]){
        
        //VOLTA A LISTA DE EXERCICIOS
        [self.myDelegate exercicioFinalizado];
    }
    
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    if ([conteudoAtivo.name isEqualToString:@"label"]) {
        conteudoAtivo.position = location;
    }else{
        conteudoAtivo = nil;
    }
    
    
    //SE A POSIÇÃO QUE FOI CLICADA É A MESMA DO SPRITE DA CAIXA, O SPRITE É MOVIDO
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    if ([conteudoAtivo.name isEqualToString:@"label"]) {
        
        
        //Ao soltar o node de resposta em algum lugar varre o vetor de caixas para descobrir sobre quem está
        float xInicio = variavel.frame.origin.x;
        float xFim = xInicio + variavel.frame.size.width;
        //float xMeio = (xInicio + xFim)/2; PARA O FUTURO
        float yInicio = variavel.frame.origin.y;
        float yFim = yInicio + variavel.frame.size.height;
        //float yMeio = (yInicio + yFim)/2; PARA O FUTURO
        
        if ((conteudoAtivo.position.x > xInicio && conteudoAtivo.position.x < xFim)&&(conteudoAtivo.position.y >yInicio && conteudoAtivo.position.y < yFim)) { // Verifica se o nó "resposta" está sobre alguma caixa
            //NSLog(@"deu certo");
            [self atualizaCaixa:variavel Label:(SpriteLabelNode *) conteudoAtivo];
            
            
            //VERIFICA SE TODOS OS TEXTOS DAS LABELS DA CAIXA FORAM ALTERADAS
            
            if (![[variavel retornaTipo] isEqualToString:@"Insira o tipo"] && ![[variavel retornaNome] isEqualToString:@"Insira o nome"] && ![[variavel retornaConteudo] isEqualToString:@"Insira o conteúdo"]) {
                NSLog(@"todas respondidas");
                [self corrigirExercicio];
            }
            
            
        }
        
        //[conteudoAtivo setPosition:CGPointMake(xMeio, yMeio)]; //Coloca o node no centro da caixa
    }
    
}










@end
