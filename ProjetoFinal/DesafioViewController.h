//
//  DesafioViewController.h
//  ProjetoFinal
//
//  Created by ANDRE NORIYUKI TOKUNAGA on 12/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DesafioOperadores.h"
#import "GerenciadorDesafios.h"
#import "Gerador.h"
#import "EstatisticaViewController.h"
#import "JCRBlurView.h"
@interface DesafioViewController : UIViewController <UIPageViewControllerDataSource, DesafioSceneDelegate>

{
    GerenciadorDesafios *gerenciadorDesafios;
    Gerador *gerador;
    SKView *viewDesafioAtual;
}

@property (strong, nonatomic) UIPageViewController *pageController;
@property (weak, nonatomic) IBOutlet UIButton *botaoVoltar;
@property (nonatomic,strong) JCRBlurView *blurView;
@end
