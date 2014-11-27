//
//  TutorialViewController.m
//  ProjetoFinal
//
//  Created by Felipe Costa Nascimento on 22/08/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "TutorialViewController.h"

@interface TutorialViewController ()

@end

@implementation TutorialViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    imagens = [NSArray arrayWithObjects:[UIImage imageNamed:@"img-tutorial.png"],
                                        [UIImage imageNamed:@"img-tutorial1.png"],
                                        [UIImage imageNamed:@"img-tutorial2.png"],
                                        [UIImage imageNamed:@"img-tutorial3.png"],
                                        [UIImage imageNamed:@"img-tutorial4.png"],
                                        [UIImage imageNamed:@"img-tutorial5.png"],
                                        [UIImage imageNamed:@"img-tutorial6.png"], nil];
    
    [self montaPaginador];
}

-(void)montaPaginador{
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:CGRectMake(9, 60, 750, 960)];
    
    FilhoViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
}


- (FilhoViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    FilhoViewController *childViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"imagensTutorial"];
    
    
    childViewController.index = index;
    childViewController.imagemAtual = [imagens objectAtIndex:index];
    
    if (index == [imagens count] -1) {
        childViewController.ultimaTela = YES;
    }else{
        childViewController.ultimaTela = NO;
    }
    
    return childViewController;
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(FilhoViewController *)viewController index];
    
    
    if (index == 0) {
        return nil;
    }
    
    // Decrease the index by 1 to return
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(FilhoViewController *)viewController index];
    
    index++;
    
    if(index == [imagens count]){
        
    }
    
    if (index == [imagens count]) {
        return nil;
    }
    
    
    
    return [self viewControllerAtIndex:index];
    
}


- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return [imagens count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)pularTutorial:(id)sender {
    
    self.view.window.rootViewController = [self.view.window.rootViewController.storyboard   instantiateViewControllerWithIdentifier:@"navigationController"];
}
@end
