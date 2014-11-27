//
//  TempViewController.m
//  ProjetoFinal
//
//  Created by RAFAEL APARECIDO DE FREITAS on 18/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "TempViewController.h"

@interface TempViewController ()

@end

@implementation TempViewController

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
    
    gerenciadorDesafios = [GerenciadorDesafios sharedGerenciador];
    gerador = [[Gerador alloc]init];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [gerenciadorDesafios selecionaDesafio:1];
    [gerenciadorDesafios instanciaTarefas];
    self.desafioAtual = [gerenciadorDesafios retornaTarefasParaDesafio];
    self.lblParte1.text = [self.desafioAtual parte1];
    self.lblOperador.text = @"?";
    self.lblParte2.text = [self.desafioAtual parte2];
    self.lblResultado.text = [self.desafioAtual resultado];
    [self ajustaBotoes];
    
    
}

-(void)ajustaBotoes{
    int aleatorio = arc4random() % 2;
    if (aleatorio == 1) {
        [self.btn1 setTitle:[self.desafioAtual operador] forState:UIControlStateNormal];
        [self.btn2 setTitle:[gerador retornaOperadorInverso:[self.desafioAtual operador]] forState:UIControlStateNormal];
    }else{
        [self.btn2 setTitle:[self.desafioAtual operador] forState:UIControlStateNormal];
        [self.btn1 setTitle:[gerador retornaOperadorInverso:[self.desafioAtual operador]] forState:UIControlStateNormal];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)acaoBotao1:(id)sender {
//    [self alteraValores];
//    [self ajustaBotoes];
    [self corrige:[[self.btn1 titleLabel]text]];
    
}

-(void)corrige:(NSString*)opcao{
    
    
    NSLog(@"%d",[gerenciadorDesafios corrige:opcao]);
    [self alteraValores];
    
}



- (IBAction)acaoBotao2:(id)sender {
[self corrige:[[self.btn2 titleLabel]text]];
}

-(void)alteraValores{
    
    if ([self.desafioAtual incrementaTarefa]) {
        self.lblParte1.text = [self.desafioAtual parte1];
        self.lblOperador.text = @"?";
        self.lblParte2.text = [self.desafioAtual parte2];
        self.lblResultado.text = [self.desafioAtual resultado];
        [self ajustaBotoes];
        //        if ([self.desafioAtual respostaDupla]) {
        //            NSLog(@"Dupla");
        //        }
    }else{
        NSLog(@"Fim");
    }
    
    
    
}


@end
