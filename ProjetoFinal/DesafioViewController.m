//
//  DesafioViewController.m
//  ProjetoFinal
//
//  Created by ANDRE NORIYUKI TOKUNAGA on 12/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "DesafioViewController.h"

@interface DesafioViewController ()
{
    DesafioScene *cenaAtual;
}

@end

@implementation DesafioViewController

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
    
    viewDesafioAtual = [[SKView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:viewDesafioAtual];
    
    cenaAtual = [gerenciadorDesafios retornaCenaAtual];
    [cenaAtual setMyDelegate:self];
    [viewDesafioAtual presentScene: cenaAtual];
    [[viewDesafioAtual scene]setSize:viewDesafioAtual.frame.size];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 50, 100, 50)];
    [btn setBackgroundColor:[UIColor blueColor]];
    [btn addTarget:self action:@selector(voltar:) forControlEvents:UIControlEventTouchUpInside];
    
    [[self view] addSubview:btn];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    //COMANDO SEM LÓGICA
    //[gerenciadorDesafios resetaCena];
}


-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)voltar:(id)sender{
    
    [cenaAtual setMyDelegate:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)inicializarPageViewController:(NSArray *)tempos nAcertos:(int)nAcertos{
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:CGRectMake(0, 100, 768, 600)];
    
    EstatisticaViewController *initialViewController = [self viewControllerAtIndex:0];
    initialViewController.vtTempos = tempos;
    initialViewController.nAcertos = nAcertos;
    
    
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
}


-(void)exibirDadosEstatisticos:(NSArray *)tempos nAcertos:(int)nAcertos nErros:(int)nErros{
    
    [self criarViewBackground];
    [self inicializarPageViewController:tempos nAcertos:nAcertos];
}


-(void)criarViewBackground{
    [self setBlurView:[JCRBlurView new]];
    [[self blurView] setFrame:self.view.frame];
    [[self blurView] setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.blurView setBlurTintColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1]];
    [self.view addSubview:[self blurView]];
    
    //LABEL DESEMPENHO
    UILabel *txtDesempenho = [[UILabel alloc] init];
    [txtDesempenho setText:@"Desempenho"];
    [txtDesempenho setFont:[UIFont fontWithName:FONT_LIGHT size:80]];
    [txtDesempenho setTextColor:[UIColor whiteColor]];
    int width = 455;
    float posX = (self.view.frame.size.width - width) / 2;
    [txtDesempenho setFrame:CGRectMake(posX, 50, width, 88)];
    [self.blurView addSubview:txtDesempenho];
}

- (EstatisticaViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    EstatisticaViewController *childViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"dadosEstatisticos"];
    [childViewController setIndex:index];
    return childViewController;
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(EstatisticaViewController *)viewController index];
    
    
    if (index == 0) {
        return nil;
    }
    
    // Decrease the index by 1 to return
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(EstatisticaViewController *)viewController index];
    
    index++;
    
//    if(index == [imagens count]){
//        
//    }
//    
    if (index == 1) {
        //return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}


- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return 2;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

@end
