//
//  TutorialViewController.h
//  ProjetoFinal
//
//  Created by Felipe Costa Nascimento on 22/08/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilhoViewController.h"

@interface TutorialViewController : UIViewController <UIPageViewControllerDataSource>
{
    NSArray *imagens;
}

@property (strong, nonatomic) UIPageViewController *pageController;
- (IBAction)pularTutorial:(id)sender;

@end
