//
//  ExercicioVIewContollerViewController.m
//  ProjetoFinal
//
//  Created by Henrique Pereira de Lima on 11/07/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "ExercicioVIewContoller.h"

@interface ExercicioVIewContoller ()
{
    
    __weak IBOutlet UIActivityIndicatorView *indicadorDeAtividade;
    UIView *viewAtividade;
    CenaExercicio *cena;
    SKView *viewExercicio;
}
@end

@implementation ExercicioVIewContoller

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    [self inicializarPropriedades];
    
}

-(void)inicializarPropriedades{
    //INSTANCIO UM GERENCIADOR PARA BUSCAR AS INFORMAÇOES DO ASSUNTO
    GerenciadorDeAssunto *gerenciador = [GerenciadorDeAssunto sharedGerenciador];
    
    //DEFINO O TITULO DO NAVIGATION CONTROLLER DE ACORDO COM O NOME DO ASSUNTO
    [[self navigationItem] setTitle:gerenciador.retornaNomeAssuntoAtual];
    
    //Ajustes No indicador de atividade
    viewAtividade = [[UIView alloc] initWithFrame:self.view.bounds];
    viewAtividade.backgroundColor = [UIColor blackColor];
    [indicadorDeAtividade startAnimating];
    [viewAtividade addSubview:indicadorDeAtividade];
    indicadorDeAtividade.center = viewAtividade.center;
    [self.view addSubview:viewAtividade];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    GerenciadorDeAssunto *gerenciador = [GerenciadorDeAssunto sharedGerenciador];
    //CRIO UMA SKVIEW PARA INSERIR A SKSCENE
    viewExercicio = [[SKView alloc] initWithFrame:self.view.frame];
    
    
    
    //Instancio o Exercicio
    [gerenciador instanciaCenaDoExercicio:[gerenciador exercicioSelecionado]];
    
    
    //INSTANCIO A SKSCENE DO ASSUNTO ATUAL
    cena = [gerenciador retornaExercicioSelecionado];
    [cena setMyDelegate:self];
    
    //DEFININDO TAMANHO DA SKSCENE E ADICIONANDO-A NA SKVIEW
    [cena setSize: viewExercicio.frame.size];
    
    [viewExercicio presentScene:cena];
    
    [[self view] addSubview:viewExercicio];
    
    [indicadorDeAtividade stopAnimating];
    [viewAtividade removeFromSuperview];
    
}

- (void) threadStartAnimating {
    [indicadorDeAtividade startAnimating];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    cena.myDelegate = nil;
    cena = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)exercicioFinalizado{

    cena.myDelegate = nil;
    cena = nil;

    //[[self navigationController] popToRootViewControllerAnimated:YES]; VOLTA PARA A PRIMEIRA TELA
    [self.navigationController popViewControllerAnimated:YES];
    
    
}



@end
