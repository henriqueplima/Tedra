//
//  SpriteEsteiraNode.m
//  DesafioVariavel
//
//  Created by Felipe Costa Nascimento on 9/21/14.
//  Copyright (c) 2014 Felipe Costa Nascimento. All rights reserved.
//

#import "SpriteEsteiraNode.h"

@implementation SpriteEsteiraNode

-(id)init{
    self = [super init];
    
    if(self){
        nodeEsteira = [[SKSpriteNode alloc] initWithImageNamed:@"esteira.png"];
        [self addChild:nodeEsteira];
        
        nodePistao = [[SKSpriteNode alloc] initWithImageNamed:@"pistao.png"];
        [nodePistao setPosition:CGPointMake(0, -170)];
        [self addChild:nodePistao];
        
        //METODOS INICIALIZADORES
        [self inicializarVetorTiposVariavel];
        [self inicializarCaixas];
        
        //METODOS POSICIONADORES
        [self posicionarCaixasInicialmente];
        
        //A ESTEIRA INICIA ABAIXADA
        esteiraLevantada = NO;
        
        
    }
    
    return self;
}


-(void)inicializarCaixas{
    vtCaixas = [[NSMutableArray alloc] init];
    
    //TOTAL DE CAIXAS QUE SERÃO GERADAS
    int nCaixas = 3;
    
    for (int i = 1; i <= nCaixas; i++) {
        SpriteCaixinhaNode *caixa = [[SpriteCaixinhaNode alloc] initWithTipoVariavel:[self gerarTipoVariavel] indexPosição:i progressaoDuracao:0.08];
        [caixa setMyDelegate:self];
        
        [vtCaixas addObject:caixa];
        [nodeEsteira addChild:caixa];

    }
}

-(void)iniciarAnimacaoDeEntrada{
    int posicaoFinal = self.position.x + nodeEsteira.size.width;
    
    SKAction *moverEsteira = [SKAction moveToX:posicaoFinal duration:1.3];
    [moverEsteira setTimingMode:SKActionTimingEaseOut];
    SKAction *moverPistao = [SKAction moveToY:nodePistao.position.y + nodePistao.size.height duration:1.3];
    [moverPistao setTimingMode:SKActionTimingEaseOut];
    
    [self runAction:moverEsteira completion:^{
        [[self myDelegate] animacaoEsteiraDeEntradaFinalizado];
        
        [nodePistao runAction:moverPistao];
    }];
    
}

-(void)posicionarCaixasInicialmente{
    //POSIÇÃO INICIAL DA PRIMEIRA CAIXA
    CGPoint posicaoCaixa = CGPointMake(-940, 180);
    
    for (SpriteCaixinhaNode *c in vtCaixas) {
        [c setPosition:posicaoCaixa];
        
        
        //DISTANCIA PADRÃO ENTRE AS CAIXAS
        posicaoCaixa.x += 245;
        
    }
    
    
    //CONTROLA A VELOCIDADE DAS CAIXAS
    if (ultimoResultado) {
        for (SpriteCaixinhaNode *c in vtCaixas) {
            [c diminuirAnimacaoDuracao];
            
        }
    
    }else{
        for (SpriteCaixinhaNode *c in vtCaixas) {
            [c aumentarDuracaoAnimacao];
            
        }
    }
    
}



//ESTE MÉTODO PEGA OS TIPOS DE DADOS QUE FORAM SORTEADOS PELAS CAIXAS  PARA ENVIÁ-LAS PARA O DELEGATE
-(void)iniciarAnimacaoDesafio{
    
    NSMutableArray *tipos = [[NSMutableArray alloc] init];
    
    //PERCORRO O VETOR DE CAIXAS PEGANDO OS TIPOS DAS CAIXAS QUE FORAM GERADOS
    for (SpriteCaixinhaNode *c in vtCaixas) {
        [tipos addObject:[c getTipo]];
    }
    
    //MANDA EXECUTAR A ANIMAÇÃO DE MOVIMENTO DA ESTEIRA
    [self executarAnimacaoMovimentoEsteira:tipos];
}


-(void)iniciarAnimacaoMoverEsteira{
    [self executarAnimacaoMovimentoEsteira:nil];
}


-(void)iniciarAnimacaoFimDaRodada{
    int posicaoFinal = 710;

    //ANIMAÇÃO QUE MOVE AS CAIXAS PARA QUE ELAS SAIAM DA TELA
    for (SpriteCaixinhaNode *c in vtCaixas) {
        
        //É PASSADO PRA CAIXA APENAS A POSIÇÃO A QUAL ELA DEVE IR E "YES" PQ É UMA ANIMAÇÃO DE FIM DO CICLO ATUAL
        [c iniciarAnimacaoMoverCaixaPara:posicaoFinal fimDesafio:YES];
    }
    
}

-(void)posicionarCaixasParaDesafio{
    int posicaoFinal = 695;

    //ANIMAÇÃO QUE MOVE AS CAIXAS PARA QUE ELAS APAREÇAM NA TELA
    for (SpriteCaixinhaNode *c in vtCaixas) {
        
        //É PASSADO PRA CAIA APENAS A POSIÇÃO A QUAL ELA DEVE IR E "NO" PQ É UMA ANIMAÇÃO DE INICIO DO DESAFIO
        [c iniciarAnimacaoMoverCaixaPara:posicaoFinal fimDesafio:NO];
    }
    
}

-(void)animacaoMoverCaixaFinalizado:(BOOL)fimDesafio{
    //VERIFICA SE A ANIMAÇÃO DA CAIXA FINALIZADA FOI DE FIM DO DESAFIO
    if (fimDesafio) {
        [self resetarTexturasDasCaixas];
        [self posicionarCaixasInicialmente];
        [[self myDelegate] rodadaAtualTerminou];
    
    }else{
        [[self myDelegate] caixasPosicionadasParaDesafio];
    }
    
}

-(void)resetarTexturasDasCaixas{
    for (SpriteCaixinhaNode *c in vtCaixas) {
        [c resetarTextura];
    }
}

//CRIO UM VETOR COM TODOS OS POSSÍVEIS TIPOS DE VARIÁVEL
-(void)inicializarVetorTiposVariavel{
    vtTiposVariavel = [[NSMutableArray alloc] init];
    [vtTiposVariavel addObject:@"inteiro"];
    [vtTiposVariavel addObject:@"caractere"];
    [vtTiposVariavel addObject:@"real"];
    [vtTiposVariavel addObject:@"logico"];
}


//ESTE MÉTODO RECEBE O TIPO DE DADO QUE ESTAVA NA CAIXA CLICADA E ENVIA PARA O DELEGATE
-(BOOL)caixaClicadaDoTipo:(NSString *)tipo{
    ultimoResultado = [[self myDelegate] respostaSelecionada:tipo];
    
    return  ultimoResultado;
}

-(void)caixaFoiClicada{
    [[self myDelegate] caixaFoiClicada];
}


-(NSString*)gerarTipoVariavel{
    //GERO UM INTEIRO ALEATÓRIO COM BASE NO VETOR QUE CONTÉM TODOS OS POSSÍVEIS TIPOS DE VARIÁVEL
    int index = arc4random() % [vtTiposVariavel count];
    
    //PEGO O TIPO DE VARÁVEL NO VETOR DE TIPOS COM O INDEX GERADO
    NSString *tipoVariavelGerado = [vtTiposVariavel objectAtIndex:index];
    
    //REMOVO O TIPO SORTEADO PARA QUE NÃO HAJA REPETIÇÃO
    [vtTiposVariavel removeObjectAtIndex:index];
    
    return tipoVariavelGerado;
}



//MÉTODO QUE REALMENTE REALIZA O MOVIMENTO DA ESTEIRA CONFORME O QUE É RECEBIDO PELO MÉTODO DE CRIAR A ANIMAÇÃO DE MOVIMENTO DA ESTEIRA
-(void)executarAnimacaoMovimentoEsteira:(NSMutableArray*)tipos{
    SKAction *mover = [self criarAnimacaoMoverEsteira];
    
    [nodeEsteira runAction:mover completion:^{
        [[self myDelegate] spriteEsteiraLevantado:esteiraLevantada tiposVariavelGerados:tipos];
    }];
}


-(SKAction*)levantarEsteira:(int)distancia duracao:(float)duracao{
    return [SKAction moveToY:nodeEsteira.position.y + distancia duration:duracao];
}


-(SKAction*)abaixarEsteira:(int)distancia duracao:(float)duracao{
    return [SKAction moveToY:nodeEsteira.position.y - distancia duration:duracao];
}

//MÉTODO RESPONSÁVEL POR LEVANTAR OU ABAIXAR A ESTEIRA CONFORME A POSIÇÃO ATUAL DELA
-(SKAction*)criarAnimacaoMoverEsteira{
    SKAction *mover;
    int distancia = 40;
    float duracao = 0.5;
    
    //ESTA VERIFICAÇÃO SERVE PARA SABER SE A ESTEIRA PRECISA SUBIR OU DESCER
    if (esteiraLevantada) {
        
        //DESABILITA O TOQUE NAS CAIXAS UM POUCO ANTES DA ESTEIRA ABAIXAR
        [self habilitarToqueNasCaixas:NO];
        
        mover = [self abaixarEsteira:distancia duracao:duracao];
        esteiraLevantada = NO;
        
    }else{
        mover = [self levantarEsteira:distancia duracao:duracao];
        esteiraLevantada = YES;
    }
    
    return mover;
}


//MÉTODO RESPONSÁVEL POR HABILITAR OU DESABILITAR A INTERAÇÃO COM AS CAIXAS
-(void)habilitarToqueNasCaixas:(BOOL)resultado{
    for (SpriteCaixinhaNode *c in vtCaixas) {
        [c setUserInteractionEnabled:resultado];
    }
}

-(void)modificarTipoDasCaixas{
    [self inicializarVetorTiposVariavel];
    
    for(SpriteCaixinhaNode *c in vtCaixas){
        [c setTipo:[self gerarTipoVariavel]];
    }
}


@end
