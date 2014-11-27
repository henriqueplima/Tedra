//
//  SubViewConteudo.h
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 02/07/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GerenciadorDeAssunto.h"
#import "AlteraAnimacaoDelegate.h"
@interface SubViewConteudo : UIViewController <UIPageViewControllerDataSource>


{
    NSMutableArray *teoria;
    GerenciadorDeAssunto *gerenciadorDeAssuntos;
}

@property (strong, nonatomic) UIPageViewController *pageController;
@property id <AlteraAnimacaoDelegate> myDelegate;


@end
