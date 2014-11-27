//
//  SubViewConteudo.m
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 02/07/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "SubViewConteudo.h"
#import "SubViewConteudoFilho.h"



@implementation SubViewConteudo

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self montaPaginador];
    [[self view] addSubview:[self.pageController view]];
}

-(void)montaPaginador{
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    SubViewConteudoFilho *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [self.pageController didMoveToParentViewController:self];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self montaPaginador];
    
    gerenciadorDeAssuntos = [GerenciadorDeAssunto sharedGerenciador];
    
    teoria = [gerenciadorDeAssuntos retornaTeoriaFormatada];
    
    //NSLog(@"%d", teoria.count);
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //RESOLVE O PROBLEMA DE PROCESSAMENTO!
    [[self pageController] removeFromParentViewController];
    self.pageController = nil;
    if ([self.myDelegate apagaDelegates]) {
        self.myDelegate = nil;
    }

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (SubViewConteudoFilho *)viewControllerAtIndex:(NSUInteger)index {
        
    SubViewConteudoFilho *childViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"textoConteudo"];

    
    childViewController.index = index;
    childViewController.myDelegate = self.myDelegate;
    
    
    
    return childViewController;
    
}



- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(SubViewConteudoFilho *)viewController index];
   
    
    if (index == 0) {
        return nil;
    }
    
    // Decrease the index by 1 to return
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(SubViewConteudoFilho *)viewController index];
    
    index++;
    
    if (index == [teoria count]) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return [teoria count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}

@end
