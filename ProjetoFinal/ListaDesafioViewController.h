//
//  ListaDesafioViewController.h
//  ProjetoFinal
//
//  Created by ANDRE NORIYUKI TOKUNAGA on 12/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GerenciadorDesafios.h"
@interface ListaDesafioViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

{
    GerenciadorDesafios* gerenciadorDesafios;
    NSMutableArray* titulosDescricoes;
}




@end
