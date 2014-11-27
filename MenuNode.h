//
//  containerView.h
//  ProjetoFinal
//
//  Created by Henrique Pereira de Lima on 15/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "IconeSecao.h"
#import "SessaoMenu.h"
#import "SecaoMenuVariavel.h"
#import "SecaoMenuOperador.h"


@protocol MenuNodeDelegate <NSObject>

- (NSMutableArray *)criarIconesVetorInfo:(NSMutableArray *)vetorInfoIcones categoria:(NSString *)categoria;

@end

@interface MenuNode : SKSpriteNode <SessaoMenuDelegate>
{
    UIScrollView *scroll;
    UIView *viewFundoScroll;
}

@property UIGestureRecognizer *panGesture;
@property NSMutableArray *imagensIcones;
@property id <MenuNodeDelegate> myDelegate;


- (void)abrirFechar;
- (id)initWithPosicaoAbrir : (CGPoint)abrir  tamanho:(CGSize)tamanho;
- (BOOL)getAberto;
- (void)removeTudo;
- (NSMutableArray *)retornaSessoes;
-(void)insereTodosIcones;
-(UIScrollView *)getScroll;
-(void)setScroll:(UIScrollView *)scrollView;
-(UIView*)getViewFundoScroll;
@end
