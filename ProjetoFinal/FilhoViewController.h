//
//  FilhoViewController.h
//  ProjetoFinal
//
//  Created by Felipe Costa Nascimento on 22/08/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilhoViewController : UIViewController
{
    
    __weak IBOutlet UIButton *btnOk;
}


@property (assign, nonatomic) NSInteger index;
@property UIImage *imagemAtual;
@property (weak, nonatomic) IBOutlet UIImageView *exibirImagem;
@property BOOL ultimaTela;
- (IBAction)finalizarTutorial:(id)sender;

@end
