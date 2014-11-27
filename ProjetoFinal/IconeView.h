//
//  TestandoNovo.h
//  ProjetoFinal
//
//  Created by Henrique Pereira de Lima on 27/10/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface IconeView : UIImageView

@property NSString *categoria;
@property NSString *tipo;


- (id)initWithCategoria:(NSString *)categoria tipo:(NSString *)tipo imagem:(NSString *)imagem;
- (id)copyWithZone:(NSZone *)zone;

@end
