//
//  CustomizadaTableViewCell.m
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 27/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "CustomizadaTableViewCell.h"
#import "GerenciadorDesafios.h"
@implementation CustomizadaTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}


-(void)setNeedsLayout{
    [super setNeedsLayout];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)acaoBtnGo:(id)sender {
    GerenciadorDesafios *gerenciador = [GerenciadorDesafios sharedGerenciador];
    [gerenciador instanciaTarefas];
    
}

-(void)mudaCorDeFundo:(int)index{
    
    GerenciadorDesafios *gerenciador = [GerenciadorDesafios sharedGerenciador];
    UIColor *cor = [gerenciador retornaCorDesafio:index];
    [[self titulo]setFont:[UIFont fontWithName:FONT_LIGHT size:40]];
    self.titulo.textColor = [UIColor whiteColor];
    [[self descricao]setFont:[UIFont fontWithName:FONT_LIGHT size:25]];
    self.descricao.textColor = [UIColor whiteColor];
    self.contentView.backgroundColor = cor;
    
    
}



@end
