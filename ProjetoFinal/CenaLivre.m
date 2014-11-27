//
//  CenaLivre.m
//  ProjetoFinal
//
//  Created by Henrique Pereira de Lima on 12/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "CenaLivre.h"
#import "SpriteOperadorNode.h"
#import "MenuNode.h"
#import "Calculador.h"
#import "OperadorNode.h"
#import "IconeView.h"
#import "Validador.h"

static const uint32_t categoriaBotaoMenu = 0x1 << 0;
static const uint32_t categoriaCaixa = 0x1 << 1;

@implementation CenaLivre{
    
    MenuNode *menu;
    SKSpriteNode *conteudoAtivo;
    SKSpriteNode *botaoMenu;
    SKSpriteNode *menuEdicao;
    NSMutableArray *vetorTextField;
    NSMutableArray *vetorOperadores;
    NSMutableArray *vetorVariaveis;
    IconeView *iconeMovimentado;
    SKSpriteNode *iconeNode;
    BOOL menuEditarAberto;
    BOOL estaEmContato;
    BOOL movendoObjeto;
    SKSpriteNode *objetoEditando;
    SpriteOperadorNode *operadorEditando;
    IconeView *iconeTemp;
    Validador *validador;
}


// METODOS DE INICIACAO

-(id)init{
    
    self = [super init];
    
    if (self) {
        
        //CONFIGURANDO CENA
        self.backgroundColor = [SKColor whiteColor];
        self.name = @"fundo";
        self.physicsWorld.contactDelegate = self;
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        
        //CRIANDO BOTAO QUE ABRE MENU
        botaoMenu = [[SKSpriteNode alloc]initWithImageNamed:@"modo livre-09.png"];
        botaoMenu.position = CGPointMake(100, 100);
        botaoMenu.name = @"botaoMenu";
        botaoMenu.zPosition = -2;
        [self addChild:botaoMenu];
        
        botaoMenu.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:botaoMenu.frame.size];
        botaoMenu.physicsBody.dynamic = NO;
        botaoMenu.physicsBody.categoryBitMask = categoriaBotaoMenu;
        botaoMenu.physicsBody.contactTestBitMask = categoriaCaixa;
        botaoMenu.physicsBody.usesPreciseCollisionDetection = YES;

        
        // alloca validador
        
        validador = [[Validador alloc]init];
        
        
        
        [self criaMenuEdicao];
        
        
        
        
    }
    return self;
}

- (void)didMoveToView:(SKView *)view{
    
    [self criandoTodosTextFields];
    [self criaGesture];
    
    //CRIANDO MENU
    menu = [[MenuNode alloc]initWithPosicaoAbrir:CGPointMake(245, 480) tamanho:CGSizeMake(490, 960)];
    
    
    // ALLOCANDO SCROLL
    
    
    UIScrollView *menuScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(74, 80, 405, 928)];
    [menuScroll setBackgroundColor:[UIColor clearColor]];
    [menuScroll setHidden:YES];
    [menu setScroll:menuScroll];
    
    // SETANDO DELEGATE
    [menu setMyDelegate:self];
    [menu insereTodosIcones];
    [self addChild:menu];
    
    
    
    
    [self.view addSubview:[menu getScroll]];
    
    
}


// Metodos Gestures

- (void)criaGesture{
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGestureRecognizer:)];
    //[longPress setMinimumPressDuration:1.5];
    //[longPress setNumberOfTouchesRequired:2];
    [longPress setNumberOfTouchesRequired:1];
    [longPress setMinimumPressDuration:0.5];
    [self.view addGestureRecognizer:longPress];
    
}

-(IBAction)ativouPanGesture:(UIPanGestureRecognizer*)recognizer{
    
    CGPoint point = [recognizer locationInView:self.view];
    if (iconeTemp == nil) {
        IconeView *icone = (IconeView *)recognizer.view;
        iconeTemp = [icone copy];
        [self.view addSubview:iconeTemp];
    }
    
    
    //[iconeTemp setFrame:CGRectMake(point.x, point.y, iconeTemp.frame.size.width, iconeTemp.frame.size.height)];
    [iconeTemp setCenter:CGPointMake(point.x, point.y)];
    
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        //NSLog(@"terminou gesture");
        [self verificaPosicaoIcone:iconeTemp];
        [iconeTemp removeFromSuperview];
        iconeTemp = nil;
        
        
    }
    
}

- (void)longPressGestureRecognizer:(UILongPressGestureRecognizer *)recognizer{
    
    //RECONHECE O GESTURE DE LONGPRESS
    
    
    if (recognizer.state == UIGestureRecognizerStateBegan){
        
        
        if ([conteudoAtivo.name isEqualToString:@"variavel"]) {
            [self tremeObjetoSelecionado:conteudoAtivo];
            [self preparaTextFieldsVariavel];
            [self moveMenuEdicao];
            objetoEditando = conteudoAtivo;
        }else if ([conteudoAtivo.name isEqualToString:@"operadorNode"] || [conteudoAtivo.name isEqualToString:@"labelOperador"]){
            conteudoAtivo = [self retornaOperadorNode:conteudoAtivo];
            [self tremeObjetoSelecionado:conteudoAtivo];
            [self preparaTextFieldsOperador];
            [self moveMenuEdicao];
            objetoEditando = (SKSpriteNode *) conteudoAtivo;
        }
    }
    
}


- (NSMutableArray *)criarIconesVetorInfo:(NSMutableArray *)vetorInfoIcones categoria:(NSString *)categoria{
    
    NSMutableArray *vetorIcones = [NSMutableArray array];
    
    for (NSDictionary *dict in vetorInfoIcones) {
        
        NSString *tipo = [dict objectForKey:@"tipo"];
        NSString *imagem = [dict objectForKey:@"imagem"];
        
        IconeView *novoIcone = [[IconeView alloc] initWithCategoria:categoria tipo:tipo imagem:imagem];
        UIGestureRecognizer *gesturePan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(ativouPanGesture:)];
        [novoIcone addGestureRecognizer:gesturePan];
        [vetorIcones addObject:novoIcone];
        
    }
    
    return vetorIcones;
    
    
}

- (void)verificaPosicaoIcone:(IconeView *)icone{
    
    float posicaoXMenu = menu.frame.size.width;
    float posicaoXIcone = icone.frame.origin.x + (icone.frame.size.width / 2);
    
    
    
    if (posicaoXIcone < posicaoXMenu) {
        NSLog(@"esta dentro");
    }else{
        [self identificaIcone:icone];
        [menu abrirFechar];
    }
    
    
    
}

- (void)identificaIcone:(IconeView *)icone{
    
    CGPoint posicao = CGPointMake(icone.frame.origin.x + 90, (self.view.frame.size.height - icone.frame.origin.y) - 55 );
    
    if ([icone.categoria isEqualToString:@"variavel"]) {
        
        [self criarVariavelTipo:icone.tipo posicao:posicao];
        
    }else if ([icone.categoria isEqualToString:@"operador"]){
        
        [self criarOperadorNaPosicao:posicao tipo:icone.tipo];
        
        
        
    }
    
}

//METODOS MENU

- (void)criaMenuEdicao{
    
    menuEdicao = [[SKSpriteNode alloc] initWithImageNamed:@"MenuEditarFundo.png"];
    [menuEdicao setSize:CGSizeMake(770, 70)];
    [menuEdicao setPosition:CGPointMake(385, 925)];
    
    
    //CRIANDO BOTAO OK
    SKSpriteNode *botaoOK = [[SKSpriteNode alloc]initWithImageNamed:@"MenuEditarBotao.png"];
    botaoOK.name = @"botaoOK";
    [botaoOK setPosition:CGPointMake(300, -3)];
    [botaoOK setSize:CGSizeMake(110, 50)];
    [menuEdicao addChild:botaoOK];
    
    
    //CRIANDO LABEL DO BOTAO OK
    SKLabelNode *lblOk = [[SKLabelNode alloc]initWithFontNamed:@"Helvetica"];
    lblOk.name = @"botaoOK";
    lblOk.fontColor = [SKColor whiteColor];
    lblOk.text = @"OK";
    lblOk.zPosition = 1;
    [lblOk setPosition:CGPointMake(botaoOK.position.x, botaoOK.position.y - 10)];
    [menuEdicao addChild:lblOk];
}

-(void)moveMenuEdicao{
    
    if (menuEditarAberto) {
        menuEditarAberto = NO;
        [menuEdicao removeFromParent];
        
    }else{
        menuEditarAberto = YES;
        [self addChild:menuEdicao];
        
    }
    
    [self mostraEscondeTextField:!menuEditarAberto];
    [self botaoMenuRoda];
}

- (void)botaoMenuRoda{
    
    SKAction *rodaBotao;
    SKTexture *texture1;
    
    
    if (menuEditarAberto) {
        //rodaBotao = [SKAction rotateToAngle: M_PI + (M_PI / 4) duration:0.4];
        rodaBotao = [SKAction rotateToAngle: -M_PI_4 duration:0.3];
        texture1 = [SKTexture textureWithImageNamed:@"modo livre-10.png"];
        
        
        
    }else{
        
        //rodaBotao = [SKAction rotateToAngle:-M_PI - M_PI duration:0.4];
        rodaBotao = [SKAction rotateToAngle: 0 duration:0.3];
        texture1 = [SKTexture textureWithImageNamed:@"modo livre-09.png"];
        
    }
    
    [botaoMenu runAction:rodaBotao completion:^{
        [botaoMenu setTexture:texture1];
    }];
    
}

- (void)botaoMenuCresci:(BOOL)cresci{
    
    //ANIMACAO BOTAO MENU
    
    
    
    
    if (cresci) {
        
        
        SKAction *rodaBotao = [SKAction rotateToAngle: -M_PI_4 duration:0.3];
        //SKTexture *texture1 = [SKTexture textureWithImageNamed:@"modo livre-10.png"];
        SKTexture *texture2 = [SKTexture textureWithImageNamed:@"modo livre-11.png"];
        SKTexture *texture3 = [SKTexture textureWithImageNamed:@"modo livre-12.png"];
        SKAction *aumenta = [SKAction resizeToWidth:150 height:150 duration:0.3];
        
        SKAction *texturas = [SKAction animateWithTextures:@[texture2,texture3] timePerFrame:0.1];
        
        SKAction *animacao = [SKAction group:@[rodaBotao,texturas,aumenta]];
        
        
        
        [botaoMenu runAction:animacao];
        
        
    }else{
        
        //DIMINUI
        
        //ANIMACAO BOTAO MENU
        
        SKAction *rodaBotao = [SKAction rotateToAngle:0 duration:0.3];

        SKTexture *texture1 = [SKTexture textureWithImageNamed:@"modo livre-11.png"];
        SKTexture *texture2 = [SKTexture textureWithImageNamed:@"modo livre-10.png"];
        SKTexture *texture3 = [SKTexture textureWithImageNamed:@"modo livre-09.png"];
        
        SKAction *texturas = [SKAction animateWithTextures:@[texture1] timePerFrame:0.1];
        SKAction *outraTextura = [SKAction animateWithTextures:@[texture2,texture3] timePerFrame:0.1];
        SKAction *diminui = [SKAction resizeToWidth:51 height:51 duration:0.3];
        SKAction *animacao = [SKAction group:@[texturas,rodaBotao,diminui,outraTextura]];
        
        [botaoMenu runAction:animacao];
        
        
    }
   
}

- (SKAction *)retornaCrescerDiminuir:(BOOL)aumenta{
    
    //ANIMACAO QUE OCORRE QUANDO USUARIO CLICA NO ICONE
    
    if (aumenta) {
        return [SKAction scaleTo:1.1 duration:0.1];
    }
    
    return [SKAction scaleTo:1 duration:0.1];
    
    
}



// METODO TEXTFIELD



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    

    

    int tipoVerificacao = [self retornaIndiceParaVerificacao:objetoEditando textField:textField];
    
    if (tipoVerificacao < 0) {
        return YES;
    }
   
    BOOL valido = [validador validaDados:tipoVerificacao string:string texto:textField.text];
    
    
    
    
    return valido;
    
}


- (int)retornaIndiceParaVerificacao:(SKNode *)objeto textField:(UITextField *)textField{
    
    
    if ([objetoEditando.name isEqualToString:@"variavel"]) {
        
        if ([textField.placeholder isEqualToString:@"insira o nome"]) {
            return 1;
        }else if ([textField.placeholder isEqualToString:@"insira o conteúdo"]){
            
            SpriteCaixaNode *variavel = (SpriteCaixaNode *)objetoEditando;
            
            if ([[variavel retornaTipo] isEqualToString:@"real"]) {
                
                return 2;
                
                
            }else if ([[variavel retornaTipo] isEqualToString:@"inteiro"]){
                return 3;
            }else if ([[variavel retornaTipo] isEqualToString:@"caractere"]){
                return 4;
            }else if ([[variavel retornaTipo] isEqualToString:@"logico"]){
                return 5;
            }
            
            
            
        }
    }else if ([objetoEditando.name isEqualToString:@"operadorSprite"]){
        
        return 2;
    }

    return 0;
    
}


- (void)criandoTodosTextFields{
    
    //ALLOCANDO VETOR TEXTFILED
    vetorTextField = [NSMutableArray array];
    
    CGRect bounds = CGRectMake(self.size.width * 0.05, self.size.height * 0.08, 250, 40);

    for (int i = 0; i < 2; i++) {
        UITextField *textField = [self criaTextFieldBounds:bounds];
        
        [self.view addSubview:textField];
        [vetorTextField addObject:textField];
        
        bounds.origin.x += bounds.size.width * 1.2;
        //bounds.origin.y += bounds.size.height * 1.5;
    }
    
}

- (UITextField *)criaTextFieldBounds:(CGRect)bounds{
    
    //CRIA E RETORNA APENAS UM TEXTFIELD
    UITextField *textField = [[UITextField alloc] initWithFrame:bounds];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.textColor = [UIColor blackColor];
    textField.font = [UIFont systemFontOfSize:25.0];
    textField.placeholder = @"Insira o valor";
    textField.backgroundColor = [UIColor whiteColor];
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    //textField.keyboardType = UIKeyboardTypeDefault;
    textField.keyboardAppearance = UIKeyboardAppearanceDark;
    textField.returnKeyType = UIReturnKeyDone;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    textField.clearsContextBeforeDrawing = YES;
    textField.delegate = self;
    textField.hidden = YES;
    
    
    return textField;
    
}

-(void)mostraEscondeTextField:(BOOL)mostra{
    
    for (UITextField *textField in vetorTextField) {
        if (!mostra) {
            
            [self limpaTextField:textField];
            
        }else{
            [textField resignFirstResponder];
        }
        
        textField.hidden = mostra;
    }
}

- (void)preparaTextFieldsVariavel{
    
    
    //NAO ESTAVA SENDO USADO !!
    //SpriteCaixaNode *variavel = (SpriteCaixaNode *)objetoEditando;
    
    for (int i = 0; i < vetorTextField.count;i++) {
        
        UITextField *textField = [vetorTextField objectAtIndex:i];
        
        switch (i) {
            case 0:
                textField.placeholder = @"insira o nome";
                break;
                
            case 1:
                textField.placeholder = @"insira o conteúdo";
                textField.keyboardType = UIKeyboardAppearanceDefault;
                //textField.keyboardType = [self variavelNumerica:variavel];
                break;
        }
    }
}

- (void)preparaTextFieldsOperador{
    
    
    
    for (int i = 0; i < vetorTextField.count;i++) {
        
        UITextField *textField = [vetorTextField objectAtIndex:i];
        textField.keyboardType = UIKeyboardTypeNumberPad;
        
        
        switch (i) {
            case 0:
                textField.placeholder = @"insira valor1";
                break;
                
            case 1:
                textField.placeholder = @"insira valor2";
                break;
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    
    if ([textField isEqual:[vetorTextField objectAtIndex:vetorTextField.count -1] ]) {
        
        if ([self validarDados]) {
            [self escondeMenuEdicao];
        }
    }
    
    
    [textField resignFirstResponder];
    
    return YES;
}

- (void)limpaTextField:(UITextField *)textField{
    
    //LIMPA A TEXTFIELD
    
    [textField resignFirstResponder];
    
    textField.text = nil;
}



// METODOS VARIAVEIS


-(void)criarVariavelTipo:(NSString *)tipo posicao:(CGPoint)posicao{
    
    if (vetorVariaveis == nil) {
        vetorVariaveis = [NSMutableArray array];
    }
    
    
    //SpriteCaixaNode *variavel = [[SpriteCaixaNode alloc]init];
    SpriteCaixaNode *variavel = [[SpriteCaixaNode alloc]initWithConteudo:nil nome:nil tipo:tipo tamanho:CGSizeMake(250, 267)];
    [variavel setPosition:posicao];
    variavel.name = @"variavel";
    variavel.zPosition = -1;
    [variavel setLabelTipo:tipo];
    [variavel setLabelEndereco:vetorVariaveis.count+1];
    [variavel controlarPelaCena:YES];
    [self addChild:variavel];
    //[variavel iniciarAnimacaoIntroducao];
    
    
    //CRIA CORPO DA CAIXA
    variavel.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:variavel.frame.size];
    variavel.physicsBody.dynamic = YES;
    variavel.physicsBody.categoryBitMask = categoriaCaixa;
    variavel.physicsBody.collisionBitMask = 0;
    variavel.physicsBody.density = 0;
    variavel.physicsBody.usesPreciseCollisionDetection = YES;
    
    [vetorVariaveis addObject:variavel];
}

- (UIKeyboardType)variavelNumerica :(SpriteCaixaNode *)variavel{
    
    NSArray *tiposVariaveis = [NSArray arrayWithObjects:@"inteiro",@"real",@"caractere",@"logico", nil];
    
    
    int i = 0;
    
    for (i = 0; i < tiposVariaveis.count; i++) {
        
        
        
        if ([[variavel retornaTipo] isEqualToString:[tiposVariaveis objectAtIndex:i]]) {
            
            break;
            
        }
        
    }
    
    switch (i) {
        case 0:
        case 1:
            return  UIKeyboardTypeNumberPad;
            break;
            
        default:
            return UIKeyboardTypeDefault;
            break;
    }
    
}



// METODOS OPERADORES

-(void)criarOperadorNaPosicao:(CGPoint)posicao tipo:(NSString *)tipo{
    
    if (vetorOperadores == nil) {
        vetorOperadores = [NSMutableArray array];
    }
    
    SpriteOperadorNode *novoOperador = [[SpriteOperadorNode alloc]initWithValor1:nil operador:tipo valor2:nil resultado:nil];
    
    [novoOperador setDono:self];
    [novoOperador setPosition:posicao];
    novoOperador.zPosition = -1;
    novoOperador.name = @"operadorSprite";
    novoOperador.myDelegateGesture = self;
    [novoOperador controladoPelaCena:YES];
    [novoOperador criarCorpos];
    
    [self addChild:novoOperador];
    [vetorOperadores addObject:novoOperador];
}

-(void)criaObjetoPosicao:(CGPoint)posicao{
    
    IconeSecao *icone = (IconeSecao *)conteudoAtivo;
    
    [icone runAction:[SKAction moveTo:icone.posicaoAnterior duration:0]];
    
    
    if ([icone.secao isEqualToString:@"variavel"]) {
        
        [self criarVariavelTipo:icone.tipo posicao:posicao];
    }else if ([icone.secao isEqualToString:@"operador"]){
        
        
        [self criarOperadorNaPosicao:posicao tipo:icone.tipo];
    }
    
}

- (void)terminouGestureOperador:(SKSpriteNode *)operador{
    
    
    if (estaEmContato) {
        [operador removeFromParent];
        [self didEndContact:nil];
    }
    
    
}



- (SpriteOperadorNode *)retornaOperadorNode :(SKSpriteNode *)objeto{
    
    //Esse metodo e usado e chamado no Touches Moved e Touches Ended
    
    // Retorna um operador Sprite Operador quando a labelOperador e clicada pelo usuario
    
    if ([objeto.name isEqualToString:@"labelOperador"]) {
        
        for (SpriteOperadorNode *spriteOperador in vetorOperadores) {
            OperadorNode *operadorNode = [spriteOperador retornaOperadorNode];
            if ([objeto isEqual:[operadorNode retornaLabelOperador]]) {
                return spriteOperador;
            }
        }
        
        
        // Retorna um operador Sprite Operador quando o operadorNode e clicada pelo usuario
        
    }else if ([objeto.name isEqualToString:@"operadorNode"]){
        for (SpriteOperadorNode *spriteOperador in vetorOperadores) {
            
            if ([objeto isEqual:[spriteOperador retornaOperadorNode]]) {
                return spriteOperador;
            }
        }

    }
    
    
    return nil;
}


// METODOS OBJETOS

- (void)tremeObjetoSelecionado:(SKSpriteNode *)objeto{
    
    SKAction *posicaoOriginal = [SKAction rotateToAngle:0.0 duration:0.1];
    SKAction *virarDireita = [SKAction rotateToAngle:0.2 duration:0.1];
    SKAction *virarEsquerda = [SKAction rotateToAngle:-0.2 duration:0.1];
    SKAction *sequencia = [SKAction sequence:@[virarDireita, virarEsquerda, posicaoOriginal]];
    
    [objeto runAction:sequencia];
    
}

- (void)criarBordaTextField:(UITextField *)textField{
    
    textField.layer.cornerRadius = 8.0f;
    textField.layer.masksToBounds = YES;
    textField.layer.borderColor = [[UIColor redColor] CGColor];
    textField.layer.borderWidth = 1.0f;
    
}

- (void)retirarBordaTextFiels{
    
    for (UITextField *textField in vetorTextField) {
        textField.layer.cornerRadius = 0.0f;
        textField.layer.masksToBounds = NO;
        textField.layer.borderWidth = 0.0f;
        //textField.layer.borderColor = [[UIColor blackColor] CGColor];
    }
    
}

- (BOOL)validarDados{
    
    if (!validador) {
        validador = [[Validador alloc]init];
    }
    NSString *mensagemErro;
    BOOL semErro;
    
    for (UITextField *textField in vetorTextField) {
        NSString *novaString = [validador removeTodoEspaco:textField.text];
        
        if (!novaString) {
            [self criarBordaTextField:textField];
            semErro = NO;
            mensagemErro = @"Preencha corretamente o campo";
        }else if ([self retornaIndiceParaVerificacao:objetoEditando textField:textField] == 5){
            
            if (![textField.text isEqualToString:@"Verdadeiro"] && ![textField.text isEqualToString:@"Falso"]) {
                [self criarBordaTextField:textField];
                semErro = NO;
                mensagemErro = @"Insira apenas Verdadeiro ou Falso";
            }
            
        }else{
            if ([self retornaIndiceParaVerificacao:objetoEditando textField:textField] == 4) {
                
                char primeiro = [textField.text characterAtIndex:0];
                char ultimo = [textField.text characterAtIndex:textField.text.length - 1];
                
                if (primeiro != '"' || ultimo != '"') {
                    NSString *aspa = @"\"";
                    textField.text = [aspa stringByAppendingFormat:@"%@%@",textField.text,aspa];
                }
                
            }
        }
    }
    
    if (semErro) {
        
        
        
        [self insereValores];
        validador.numeroErros = 0;
    }else{
        validador.numeroErros += 1;
        
        if (validador.numeroErros > 1) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"erro" message:mensagemErro delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alertView show];
            validador.numeroErros = 0;
        }
        
    }
    
    
    return semErro;
}

- (void)insereValores{
    
    
    //INSERE VALOR VARIAVEIS
    if ([objetoEditando.name isEqualToString:@"variavel"]) {
        SpriteCaixaNode *variavel = (SpriteCaixaNode *)objetoEditando;
        
        for (int i = 0; i < vetorTextField.count;i++) {
            
            UITextField *textField = [vetorTextField objectAtIndex:i];
            
            
            switch (i) {
                case 0:
                    [variavel setLabelNome:textField.text];
                    break;
                    
                case 1:
                    [variavel setLabelConteudo:textField.text];
                    break;
            }
        }
        
        // INSERE VALOR NO OPERADOR
        
    }else if ([objetoEditando.name isEqualToString:@"operadorSprite"] || [objetoEditando.name isEqualToString:@"labelOperador"]){
        
        //SpriteOperadorNode *operador = [self retornaOperadorNode:objetoEditando];
        SpriteOperadorNode *operador = (SpriteOperadorNode *)objetoEditando;
        for (int i = 0; i < vetorTextField.count;i++) {
            
            UITextField *textField = [vetorTextField objectAtIndex:i];
            switch (i) {
                case 0:
                    [operador setLabelValor1:textField.text];
                    
                    break;
                    
                case 1:
                    [operador setLabelValor2:textField.text];
                    break;
            }
        }
        
        Calculador *calculador = [[Calculador alloc]init];
        
        
        [operador setLabelResultado:[calculador calculaOperador:[operador getOperador] numero1:[operador getValor1] numero2:[operador getValor2]]];
        
    }
    
    [self moveMenuEdicao];
    objetoEditando = nil;
}

- (void)escondeMenuEdicao{
    
    if (menuEditarAberto) {
        [self moveMenuEdicao];
        [self retirarBordaTextFiels];
    }
    
}

- (void)identificaNode{
    
    if ([conteudoAtivo isEqual:objetoEditando]) {
        return;
    }
    
    if ([conteudoAtivo.name isEqualToString:@"botaoMenu"]) {
        [menu abrirFechar];
        [self.myDelegate esconderNavigationController: [menu getAberto]];
        
        
    }else if ([menu getAberto] && [conteudoAtivo.name isEqualToString:@"fundo"]){
        [menu abrirFechar];
        [self.myDelegate esconderNavigationController: [menu getAberto]];
    }else if ([conteudoAtivo.name isEqualToString:@"iconeMenu"]){
        [conteudoAtivo runAction:[self retornaCrescerDiminuir:YES]];
    }else if ([conteudoAtivo.name isEqualToString:@"botaoOK"]){
        if (![self validarDados]) {
            return;
        }
    }
    
    [self escondeMenuEdicao];
    
}

- (void)removeDelegates{
    
    
    [vetorVariaveis removeAllObjects];
    
    
    for (int i = 0;i < vetorOperadores.count;i++) {
        
        SpriteOperadorNode *operador = [vetorOperadores objectAtIndex:i];
        operador.myDelegateGesture = nil;
    }
    
    [vetorOperadores removeAllObjects];
    
    [menu removeTudo];
    
    [self removeAllChildren];
    [self removeAllActions];
    self.myDelegate = nil;
    
}


// METODOS CONTATOS

- (void)didBeginContact:(SKPhysicsContact *)contact{
    
    NSLog(@"entrou contato");
    estaEmContato = YES;
    
    [self botaoMenuCresci:YES];
    
    
}

- (void)didEndContact:(SKPhysicsContact *)contact{
    estaEmContato = NO;
    [self botaoMenuCresci:NO];
}



// METODOS TOUCHES

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    UITouch *touch = [touches anyObject];
    CGPoint location =  [touch locationInNode:self];
    
    
    
    conteudoAtivo = (SKSpriteNode*)[self nodeAtPoint:location];
    
    [self identificaNode];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    //SE A POSIÇÃO QUE FOI CLICADA É A MESMA DO SPRITE DA CAIXA, O SPRITE É MOVIDO
    
    if (!movendoObjeto && ([conteudoAtivo.name isEqualToString:@"operadorNode"] || [conteudoAtivo.name isEqualToString:@"labelOperador"])) {
        conteudoAtivo = (SKSpriteNode *)[self retornaOperadorNode:conteudoAtivo];
        
        
        
    }else if ([conteudoAtivo.name isEqualToString:@"variavel"] || [conteudoAtivo.name isEqualToString:@"operadorSprite"]){
        
        UITouch *touch = [touches anyObject];
        CGPoint scenePosition = [touch locationInNode:self];
        CGPoint lastPosition = [touch previousLocationInNode:self];
        
        // CALCULO PARA ARRASTAR O NODE SEM CENTRALIZA-LO EM RELAÇÃO AO TOQUE
        CGPoint novaPosicao = CGPointMake(conteudoAtivo.position.x + (scenePosition.x - lastPosition.x), conteudoAtivo.position.y + (scenePosition.y - lastPosition.y));
        
        
        
        //MEXER DEPOIS !!!!!!!!!
        float posicaoXInicio = novaPosicao.x - ([conteudoAtivo size].width / 2);
        float posicaoXFim = novaPosicao.x + ([conteudoAtivo size].width / 2);
//        int posicaoXInicio = novaPosicao.x - 50;
//        int posicaoXFim = novaPosicao.x + 50;
        if(posicaoXFim > self.view.frame.size.width || posicaoXInicio < 0){
            return;
        }
        
        float posicaoYInicio = novaPosicao.y - ([conteudoAtivo size].height / 2);
        float posicaoYFim = novaPosicao.y + ([conteudoAtivo size].height / 2);
//        int posicaoYInicio = novaPosicao.y - 50;
//        int posicaoYFim = novaPosicao.y + 50;
        if(posicaoYFim > self.view.frame.size.height || posicaoYInicio < 0){
            return;
        }
        
        conteudoAtivo.position = novaPosicao;
        movendoObjeto = YES;
        
        
        /* Faz mover a view, fica bem dahora, sera util algum dia
        [self.view setTransform:CGAffineTransformTranslate(CGAffineTransformIdentity, (location.x + self.view.frame.origin.x - dx), 0.0)];
        
        */
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (estaEmContato) {
        [conteudoAtivo removeFromParent];
        [self didEndContact:nil];
        if (menuEditarAberto) {
            [self moveMenuEdicao];
        }
        return;
    }
    
    if ([conteudoAtivo.name isEqualToString:@"variavel"] && !movendoObjeto) {
        
        
            SpriteCaixaNode *variavel = (SpriteCaixaNode *)conteudoAtivo;
            [variavel executaSprite];
        
    }else if (([conteudoAtivo.name isEqualToString:@"operadorNode"] || [conteudoAtivo.name isEqualToString:@"labelOperador"]) && !movendoObjeto){
        SpriteOperadorNode *spriteOperador = [self retornaOperadorNode:conteudoAtivo];
        NSLog(@"nome objeto: %@",spriteOperador.name);
        if ([spriteOperador isKindOfClass:[SpriteOperadorNode class]]) {
            [spriteOperador iniciarAnimacoes];
        };
        
    }
    
    
    if ([conteudoAtivo.name isEqualToString:@"iconeMenu"]) {
        
        UITouch *touch = [touches anyObject];
        CGPoint location = [touch locationInNode:self];
        
        float xInicio = menu.frame.origin.x;
        float xFim = xInicio + menu.frame.size.width;
        float yInicio = menu.frame.origin.y;
        float yFim = yInicio + menu.frame.size.height;
        

        if ((location.x >= xInicio && location.x <= xFim) && (location.y >= yInicio && location.y <= yFim)) {
            
            
            IconeSecao *icone = (IconeSecao *)conteudoAtivo;
            [icone runAction:[SKAction moveTo:icone.posicaoAnterior duration:0.3]];
            [icone runAction:[self retornaCrescerDiminuir:NO]];
            
            
        }else{
            
            [self criaObjetoPosicao:location];
            
            [menu abrirFechar];
            [self.myDelegate esconderNavigationController: [menu getAberto]];
            
            
        }
        
        
        
    }
    conteudoAtivo = nil;
    movendoObjeto = NO;
}

@end
