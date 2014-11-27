//
//  SubViewConteudoFilho.h
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 02/07/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GerenciadorDeAssunto.h"
#import "ConteudoViewController.h"
#import "AlteraAnimacaoDelegate.h"

@interface SubViewConteudoFilho : UIViewController
{
    GerenciadorDeAssunto *gerenciadorDeAssuntos;
    NSMutableArray *teoria;
    __weak IBOutlet UITextView *txtConteudo;
    ConteudoViewController *viewDeConteudo;
}
@property (assign, nonatomic) NSInteger index;

@property id <AlteraAnimacaoDelegate> myDelegate;

@property (weak, nonatomic) IBOutlet UILabel *lblConteudo;

@end
