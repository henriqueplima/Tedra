//
//  LivreViewController.m
//  ProjetoFinal
//
//  Created by ANDRE NORIYUKI TOKUNAGA on 12/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "LivreViewController.h"
#import "GerenciadorDesafios.h"
@interface LivreViewController (){

    SKView *viewLivre;
    UIView *novaView;
    CenaLivre *cena;
}

@end

@implementation LivreViewController

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
    
	
    novaView = [[UIView alloc]initWithFrame:self.view.bounds];
    
    //[self.view addSubview:novaView];
    
    viewLivre = [[SKView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:viewLivre];
    
    cena = [[CenaLivre alloc]init];
    
    [cena setSize: viewLivre.frame.size];
    //[cena setSize: viewExercicio.frame.size];
    [cena setMyDelegate:self];
    [viewLivre presentScene:cena];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:109.0/255.0 green:157.0/255.0 blue:132.0/255.0 alpha:1.0];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [UIColor whiteColor],NSForegroundColorAttributeName, // Cor
                          [UIFont fontWithName:FONT_MEDIUM size:25],NSFontAttributeName, // Font Style
                          
                          nil];
    
    [self.navigationController.navigationBar setTitleTextAttributes:dict];

    
}

//-(void)viewWillAppear:(BOOL)animated{
    //[super viewWillAppear:animated];
    
    
//    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:109.0/255.0 green:157.0/255.0 blue:132.0/255.0 alpha:1.0];
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//    
//    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
//                          [UIColor whiteColor],NSForegroundColorAttributeName, // Cor
//                          [UIFont fontWithName:FONT_MEDIUM size:25],NSFontAttributeName, // Font Style
//                          
//                          nil];
//    
//    [self.navigationController.navigationBar setTitleTextAttributes:dict];
    
    
//}

//- (void)viewDidAppear:(BOOL)animated{
    
//    cena = [[CenaLivre alloc]init];
//    
//    [cena setSize: viewLivre.frame.size];
//    //[cena setSize: viewExercicio.frame.size];
//    [cena setMyDelegate:self];
//    [viewLivre presentScene:cena];
    
//}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    [cena removeDelegates];
    cena = nil;
    
    
}


- (void) esconderNavigationController:(BOOL)esconder{
    
    //ESCONDE A NAVIGATION CONTROLLER
    //[self.navigationController setNavigationBarHidden:esconder animated:NO];
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
