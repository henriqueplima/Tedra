//
//  SecaoMenu.h
//  ProjetoFinal
//
//  Created by Henrique Pereira de Lima on 16/09/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GerenciadorDesafios.h"
#import "IconeSecao.h"
#import "IconeView.h"

@protocol SessaoMenuDelegate <NSObject>

- (void)sessaoAtivada:(NSString*)tipo infoIcones:(NSMutableArray *)vetorInfoIcones;

@end




@interface SessaoMenu : SKSpriteNode
{
    SKLabelNode *lblSessao;
    SKAction *moverDireita;
    SKAction *moverEsquerda;
}


@property NSMutableArray *tiposIcones;
@property id<SessaoMenuDelegate> myDelegate;
@property NSString *titulo;

- (id)init;
- (int)retornaNumeroIcones;
- (NSMutableArray *)retornaInfoIcones;
- (NSDictionary *)retornaDictionaryPorIndice:(int)indice;
-(void)ativarAnimacaoSecaoAtivada;
-(void)ativarAnimacaoSecaoDesativada;
-(void)inicializarAnimacoesMovimento;




@end
