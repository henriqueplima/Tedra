//
//  SubViewConteudoFilho.m
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 02/07/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "SubViewConteudoFilho.h"

@interface SubViewConteudoFilho ()

@end

@implementation SubViewConteudoFilho

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    
    return self;
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    viewDeConteudo = [self.storyboard instantiateViewControllerWithIdentifier:@"conteudo"];
    self.view.backgroundColor = [UIColor darkGrayColor];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    
    
    gerenciadorDeAssuntos = [GerenciadorDeAssunto sharedGerenciador];
    
    teoria = [gerenciadorDeAssuntos retornaTeoriaFormatada];
    
    
    // PONTO CHAVE

    [self.myDelegate trocaAnimacao:(int)self.index + 1];

    
    txtConteudo.text = [teoria objectAtIndex:self.index];
    [txtConteudo setFont:[UIFont fontWithName:@"Avenir Next Condensed" size:23.0]];
    [txtConteudo setTextColor:[UIColor whiteColor]];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    if ([self.myDelegate apagaDelegates]) {
        self.myDelegate = nil;
    }
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

@end
