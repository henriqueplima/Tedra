//
//  ConteudoViewController.h
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 29/06/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animacao.h"
#import "AlteraAnimacaoDelegate.h"
#import "GerenciadorDeAssunto.h"

@interface ConteudoViewController : UIViewController <AlteraAnimacaoDelegate>
{
    GerenciadorDeAssunto *gerenciador;
    BOOL primeiraChamada;
    Animacao *cenaAtual;
    SKView *viewAnimacao;
    int totalPaginas;
    __weak IBOutlet UILabel *numeroPaginas;
    bool mantemDelegates;
}
@property (weak, nonatomic) IBOutlet UIView *myViewContainer;


@end
