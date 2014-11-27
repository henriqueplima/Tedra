//
//  MenuViewController.m
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 29/06/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "MenuViewController.h"
#import "Calculador.h"
#import "GerenciadorDesafios.h"
@interface MenuViewController ()

@end

static const int BOTAO_WIDTH = 150;
static const int BOTAO_HEIGHT = 102;
static const int ESPACAMENTO_BOTOES = 50;

@implementation MenuViewController


-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        gerenciadorDeAssuntos = [GerenciadorDeAssunto sharedGerenciador];
        
        nBotoesNasLinhas = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],
                            [NSNumber numberWithInt:1],
                            [NSNumber numberWithInt:2],
                            [NSNumber numberWithInt:3],
                            [NSNumber numberWithInt:2],
                            [NSNumber numberWithInt:3], nil];
        
        
        
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:180.0/255.0 green:77.0/255.0 blue:84.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [UIColor whiteColor],NSForegroundColorAttributeName, // Cor
                          [UIFont fontWithName:FONT_MEDIUM size:25],NSFontAttributeName, // Font Style
                          
                          nil];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dict];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //COMANDO PARA MUDAR A COR DA NAVIGATION CONTROLLER
    //[[self.navigationController navigationBar] setBarTintColor:[UIColor whiteColor]];
    
    //É DEFINIDO O TAMANHO E A POSIÇÃO DA SCROLLVIEW EM RELAÇÃO O TAMANHO DO NAVIGATION CONTROLLER
    CGRect frame = self.view.frame;
    frame.origin.y = 64;
    frame.size.height = self.view.frame.size.height - frame.origin.y;
    
    //INICIALIZA A SCROLLVIEW
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:frame];
    [scroll setBackgroundColor:[UIColor lightGrayColor]];
    [scroll setUserInteractionEnabled:YES];
    [scroll setScrollEnabled:YES];
    [[self view] addSubview:scroll];
    
    int contadorNomes = 0;
    int posicaoYView = 1;
    
    for(int i=0; i<nBotoesNasLinhas.count; i++){
        //INICIALIZA VIEW DE FUNDO
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(scroll.frame.origin.x, posicaoYView, scroll.frame.size.width, 250)];
        [view setBackgroundColor:[UIColor whiteColor]];
        [scroll addSubview:view];
        
        
        //POSIÇOES DO BOTAO
        int posicaoXBotao = (view.frame.size.width / 2) - (BOTAO_WIDTH / 2);
        int posicaoYBotao = (view.frame.size.height / 2) - (BOTAO_HEIGHT / 2);
        
        switch ([[nBotoesNasLinhas objectAtIndex:i] intValue]) {
            case 1:
                contadorNomes += [self posicionarUmBotao:view :posicaoXBotao :posicaoYBotao :contadorNomes];
                break;
                
            case 2:
                contadorNomes += [self posicionarDoisBotoes:view :posicaoXBotao :posicaoYBotao :contadorNomes];
                break;
                
            case 3:
                contadorNomes += [self posicionarTresBotoes:view :posicaoXBotao :posicaoYBotao :contadorNomes];
                break;
                
            default:
                break;
        }
        
        
        //DEFINE NOVA POSIÇAO Y PARA A PROXIMA VIEW
        posicaoYView += view.frame.size.height + 1;
    }
    
    [scroll setContentSize:CGSizeMake(scroll.frame.size.width, posicaoYView)];
}


//METODO QUE INSERE UM BOTÃO NA LINHA
-(int)posicionarUmBotao:(UIView*)view :(int)posicaoXBotao :(int)posicaoYBotao :(int)contadorNomes{
    
    //INICIALIZA BOTAO
    UIButton *botao = [[UIButton alloc] initWithFrame:CGRectMake(posicaoXBotao, posicaoYBotao, BOTAO_WIDTH, BOTAO_HEIGHT)];
    [botao setImage:[self retornaImagemBotao:contadorNomes] forState:UIControlStateNormal];
    [botao setTitle:[gerenciadorDeAssuntos getNomedoAssunto:contadorNomes] forState:UIControlStateNormal];
    [botao addTarget:self action:@selector(mostrarAssunto:) forControlEvents:UIControlEventTouchUpInside];
    [self inserirLabelTituloAssunto:view posicaoBase:posicaoXBotao titulo:botao.currentTitle];
    
    if(contadorNomes > 3 ){
        botao.enabled = NO;
    }
    
    [view addSubview:botao];
    
    
    return 1;
}

//METODO QUE INSERE DOIS BOTÕES NA LINHA
-(int)posicionarDoisBotoes:(UIView*)view :(int)posicaoXBotao :(int)posicaoYBotao :(int)contadorNomes{
    
    int posicaoBotao1 = posicaoXBotao - (BOTAO_WIDTH /2) - (ESPACAMENTO_BOTOES / 2);
    int posicaoBotao2 = posicaoXBotao + (BOTAO_WIDTH /2) + (ESPACAMENTO_BOTOES / 2);

    
    //INICIALIZA BOTAO
    UIButton *botao = [[UIButton alloc] initWithFrame:CGRectMake(posicaoBotao1, posicaoYBotao, BOTAO_WIDTH, BOTAO_HEIGHT)];
    [botao setImage:[self retornaImagemBotao:contadorNomes] forState:UIControlStateNormal];
    [botao addTarget:self action:@selector(mostrarAssunto:) forControlEvents:UIControlEventTouchUpInside];
    [botao setTitle:[gerenciadorDeAssuntos getNomedoAssunto:contadorNomes++] forState:UIControlStateNormal];
    [self inserirLabelTituloAssunto:view posicaoBase:posicaoBotao1 titulo:botao.currentTitle];
    
    
    //INICIALIZA SEGUNDO BOTÃO
    UIButton *botao2 = [[UIButton alloc] initWithFrame:CGRectMake(posicaoBotao2, posicaoYBotao, BOTAO_WIDTH, BOTAO_HEIGHT)];
    [botao2 setImage:[self retornaImagemBotao:contadorNomes] forState:UIControlStateNormal];
    [botao2 addTarget:self action:@selector(mostrarAssunto:) forControlEvents:UIControlEventTouchUpInside];
    [botao2 setTitle:[gerenciadorDeAssuntos getNomedoAssunto:contadorNomes] forState:UIControlStateNormal];
    [self inserirLabelTituloAssunto:view posicaoBase:posicaoBotao2 titulo:botao2.currentTitle];
    
    [view addSubview:botao];
    [view addSubview:botao2];
    
    if(contadorNomes > 3 ){
        botao.enabled = NO;
        botao2.enabled = NO;
    }
    botao2.enabled = NO;
    
    
    return 2;
}


//METODO QUE INSERE TRÊS BOTÕES NA LINHA
-(int)posicionarTresBotoes:(UIView*)view :(int)posicaoXBotao :(int)posicaoYBotao :(int)contadorNomes{
    int posicaoBotao1 = posicaoXBotao - BOTAO_WIDTH - ESPACAMENTO_BOTOES;
    int posicaoBotao2 = posicaoXBotao + BOTAO_WIDTH + ESPACAMENTO_BOTOES;
    
    //INICIALIZA BOTAO DA ESQUERDA
    UIButton *botao = [[UIButton alloc] initWithFrame:CGRectMake(posicaoBotao1, posicaoYBotao, BOTAO_WIDTH, BOTAO_HEIGHT)];
    [botao setImage:[self retornaImagemBotao:contadorNomes] forState:UIControlStateNormal];
    [botao addTarget:self action:@selector(mostrarAssunto:) forControlEvents:UIControlEventTouchUpInside];
    [botao setTitle:[gerenciadorDeAssuntos getNomedoAssunto:contadorNomes++] forState:UIControlStateNormal];
    [self inserirLabelTituloAssunto:view posicaoBase:posicaoBotao1 titulo:botao.currentTitle];
    
    //INICIALIZA BOTÃO DO MEIO
    [self posicionarUmBotao:view :posicaoXBotao :posicaoYBotao :contadorNomes++];
    
    //INICIALIZA BOTÃO DA DIREITA
    UIButton *botao2 = [[UIButton alloc] initWithFrame:CGRectMake(posicaoBotao2, posicaoYBotao, BOTAO_WIDTH, BOTAO_HEIGHT)];
    [botao2 setImage:[self retornaImagemBotao:contadorNomes] forState:UIControlStateNormal];
    [botao2 addTarget:self action:@selector(mostrarAssunto:) forControlEvents:UIControlEventTouchUpInside];
    [botao2 setTitle:[gerenciadorDeAssuntos getNomedoAssunto:contadorNomes] forState:UIControlStateNormal];
    [self inserirLabelTituloAssunto:view posicaoBase:posicaoBotao2 titulo:botao2.currentTitle];
    
    [view addSubview:botao];
    [view addSubview:botao2];
    
    if(contadorNomes > 3 ){
        botao.enabled = NO;
        botao2.enabled = NO;
    }
    
    
    
    
    return 3;
}


-(UIImage*)retornaImagemBotao:(int)contadorNomes{
    return [UIImage imageNamed:[NSString stringWithFormat:@"item-%@.png", [gerenciadorDeAssuntos getNomedoAssunto:contadorNomes]]];
}


-(void)inserirLabelTituloAssunto:(UIView*)view posicaoBase:(int)posicaoX titulo:(NSString*)titulo{
//    CGRect frame;
//    frame.size.width = 100;
//    frame.size.height = 15;
//    frame.origin.x = ((view.frame.size.width / 2) - (frame.size.width / 2));
//    frame.origin.y = view.frame.size.height - 50;
    
    //INICIALIZA OS NUMEROS EXIBIDOS NA TELA
//    UILabel *texto = [[UILabel alloc] initWithFrame:frame];
//    [texto setText:titulo];
//    [texto setTextAlignment:NSTextAlignmentCenter];
//    [texto setTextColor:[UIColor grayColor]];
//    [texto setFont:[UIFont fontWithName:@"Avenir Next Condensed" size:17]];
//    [view addSubview:texto];
    
    
    CGRect frame;
    frame.size.width = 100;
    frame.size.height = 15;
    frame.origin.x = posicaoX + (BOTAO_WIDTH / 2) - (frame.size.width / 2);
    frame.origin.y = view.frame.size.height - 60;
    
    //INICIALIZA OS NUMEROS EXIBIDOS NA TELA
    UILabel *texto2 = [[UILabel alloc] initWithFrame:frame];
    [texto2 setText:titulo];
    [texto2 setTextAlignment:NSTextAlignmentCenter];
    [texto2 setTextColor:[UIColor grayColor]];
    [texto2 setFont:[UIFont fontWithName:@"Avenir Next Condensed" size:17]];
    [view addSubview:texto2];
}

-(void)mostrarAssunto:(id)sender{
    
    
    [self performSegueWithIdentifier:@"conteudoController" sender:nil];

    
    [gerenciadorDeAssuntos mudarTemaEstudado:[sender currentTitle]];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
