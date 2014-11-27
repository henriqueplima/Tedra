//
//  CustomizadaTableViewCell.h
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 27/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomLabel.h"
@interface CustomizadaTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *descricao;
@property (strong, nonatomic) IBOutlet UILabel *titulo;
@property (weak, nonatomic) IBOutlet UIButton *btnGo;

- (IBAction)acaoBtnGo:(id)sender;
-(void)mudaCorDeFundo:(int)index;


@end
