//
//  FilhoViewController.m
//  ProjetoFinal
//
//  Created by Felipe Costa Nascimento on 22/08/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "FilhoViewController.h"

@interface FilhoViewController ()

@end

@implementation FilhoViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[self exibirImagem] setImage:self.imagemAtual];
    
    if(self.ultimaTela){
        [btnOk setHidden:NO];
    }else{
        [btnOk setHidden:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)finalizarTutorial:(id)sender {
    self.view.window.rootViewController = [self.view.window.rootViewController.storyboard   instantiateViewControllerWithIdentifier:@"navigationController"];
}
@end
