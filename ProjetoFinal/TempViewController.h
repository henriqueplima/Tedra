//
//  TempViewController.h
//  ProjetoFinal
//
//  Created by RAFAEL APARECIDO DE FREITAS on 18/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DesafioOperadores.h"
#import "GerenciadorDesafios.h"
#import "Gerador.h"
@interface TempViewController : UIViewController

{
    int nivel;
    NSString *tipo;
    GerenciadorDesafios *gerenciadorDesafios;
    Gerador *gerador;
}
@property DesafioOperadores *desafioAtual;

@property (weak, nonatomic) IBOutlet UILabel *lblParte1;
@property (weak, nonatomic) IBOutlet UILabel *lblOperador;
@property (weak, nonatomic) IBOutlet UILabel *lblParte2;
@property (weak, nonatomic) IBOutlet UILabel *lblResultado;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;

- (IBAction)acaoBotao1:(id)sender;
- (IBAction)acaoBotao2:(id)sender;


@end
