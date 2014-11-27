//
//  SpriteCronometroNode.m
//  DesafioVariavel
//
//  Created by Felipe Costa Nascimento on 9/23/14.
//  Copyright (c) 2014 Felipe Costa Nascimento. All rights reserved.
//

#import "SpriteCronometroNode.h"

@implementation SpriteCronometroNode


-(id)initWithTempoTotalEmSegundos:(float)tempo progressaoDeTempo:(float)progressao{
    self = [super initWithImageNamed:@"cronometro.png"];
    
    if(self){
        
        [self inicializarClasse:tempo];
        [self setProgressaoTempo:progressao];
    }
    
    return self;
}

-(id)initWithTempoTotalEmSegundos:(float)tempo{
    self = [super initWithImageNamed:@"cronometro.png"];
    
    if(self){
        [self inicializarClasse:tempo];
        [self setProgressaoTempo:0];
    }
    
    return self;
}

-(void)inicializarClasse:(float)tempo{
    //INICIALMENTE A BARRA DE TEMPO COMEÇA BEM PEQUENA MAS EM SEGUIDA JÁ INICIA UMA ANIMAÇÃO PRA FICAR TOTALMENTE PREENCHIDA
    [self setSize:CGSizeMake(0, self.size.height)];
    
    vtTempoDeResposta = [[NSMutableArray alloc] init];
    tempoTotal = tempo;
    widthSize = 768;
    nAcertos = 0;
    nErros = 0;
    
    [self inicializarAnimacaoIniciarContagem];
}


-(SKAction*)gerarAnimacaoPrepararCronometro{
    //CÁLCULO PARA MANTER A BARRINHA SEMPRE NO CANTO DIREITO
    float posicaoFinal = -((widthSize - self.size.width) / 2);
    
    SKAction *mover = [SKAction moveByX:posicaoFinal y:0 duration:1];
    SKAction *resize = [SKAction resizeToWidth:widthSize duration:1];
    
    //ANIMAÇÃO DO TIPO GROUP, EXECUTA UM VETOR DE ANIMAÇÕES AO MESMO TEMPO
    return [SKAction group:@[mover, resize]];
}


-(void)inicializarAnimacaoIniciarContagem{
    SKAction *mover = [SKAction moveByX:widthSize / 2 y:0 duration:tempoTotal];
    SKAction *resize = [SKAction resizeToWidth:0 duration:tempoTotal];
    
    //ANIMAÇÃO DO TIPO GROUP, EXECUTA UM VETOR DE ANIMAÇÕES AO MESMO TEMPO
    acaoIniciarContagem = [SKAction group:@[mover, resize]];
}


//MODIFICA O TEMPO E INICIALIZA A ACTION COM A NOVA DURAÇAO DE TEMPO
-(void)setTempoTotal:(float)tempo{
    if (tempo < 1) {
        tempo = 1;
    
    }else if(tempo > 15){
        tempo = 15;
    }
    
    
    tempoTotal = tempo;
    [self inicializarAnimacaoIniciarContagem];
}


-(void)prepararCronometro{
    [self removeAllActions];
    [vtTempoDeResposta addObject:[self calcularTempoDeResposta]];
    [self runAction:[self gerarAnimacaoPrepararCronometro]];

}


-(void)usuarioErrouResposta{
    float novoTempo = 0;
    
    //SISTEMA DE PROGRESSÃO DE TEMPO EM CASO DE ERRO
    switch (nErros) {
        case 0:
            //NO PRIMEIRO CASO O TEMPO CONTINUA O MESMO
            nErros++;
            nAcertos = 0;
            novoTempo = tempoTotal;
            break;
            
        case 1:
            //NO SEGUNDO CASO, O TEMPO É AUMENTADO COM BASE NO TEMPO DE PROGRESSÃO, DEFINIDO AO CRIAR ESTA CLASSE
            nErros++;
            prograssaoTempoDinamica = self.progressaoTempo;
            novoTempo = tempoTotal + prograssaoTempoDinamica;
            break;
            
        case 2:
            //NESTE ÚLTIMO CASO, O TEMPO É EXPONENCIALMENTE AUMENTADO DE 2 EM 2 VEZES
            prograssaoTempoDinamica *= 2;
            novoTempo = tempoTotal + prograssaoTempoDinamica;
            
        default:
            break;
    }
    
    //CHAMA METODO QUE AUMENTA O TEMPO DO CRONOMETRO COM BASE NA VARIAVEL progressaoTempo DEFINIDA ANTERIORMENTE
    [self setTempoTotal:novoTempo];
}

-(void)usuarioAcertouResposta{
    float novoTempo = 0;
    
    //SISTEMA DE PROGRESSÃO DE TEMPO EM CASO DE ACERTO
    switch (nAcertos) {
        case 0:
            //NO PRIMEIRO CASO O TEMPO CONTINUA O MESMO
            nAcertos++;
            nErros = 0;
            novoTempo = tempoTotal;
            break;
            
        case 1:
            //NO SEGUNDO CASO, O TEMPO É DIMINUÍDO COM BASE NO TEMPO DE PROGRESSÃO, DEFINIDO AO CRIAR ESTA CLASSE
            nAcertos++;
            prograssaoTempoDinamica = self.progressaoTempo;
            novoTempo = tempoTotal - prograssaoTempoDinamica;
            break;
            
        case 2:
            //NESTE ÚLTIMO CASO, O TEMPO É EXPONENCIALMENTE DIMINUIDO DE 2 EM 2 VEZES
            prograssaoTempoDinamica *= 2;
            novoTempo = tempoTotal - prograssaoTempoDinamica;
            
        default:
            break;
    }
    
    //CHAMA METODO QUE DIMINUI O TEMPO DO CRONOMETRO COM BASE NA VARIAVEL progressaoTempo DEFINIDA ANTERIORMENTE
    [self setTempoTotal:novoTempo];
}



//ESTE MÉTODO FAZ AS ANIMAÇÕES 
-(void)iniciarAnimacaoDeEntrada{
    [self runAction:[self gerarAnimacaoPrepararCronometro]];
    [[self myDelegate] animacaoDeEntradaCronometroFinalizada];
}


-(void)prepararCronometroComNovoTempo:(float)tempo{
    tempoTotal = tempo;
    [self prepararCronometro];

}


-(void)iniciarContagem{
    //SE ESTE MÉTODO FOR CHAMADO E O TEMPO ESTIVER COM ZERO, É LANÇADA UMA EXCESSÃO DE ERRO
    if (tempoTotal == 0) {
        @throw [NSException exceptionWithName:@"Tempo total não definido" reason:@"É necessário definir um tempo total maior que 0 para que o cronômetro possa funcionar." userInfo:nil];
    }
    
    
    [self runAction:acaoIniciarContagem completion:^{
        [[self myDelegate] tempoEsgotado];
    }];
}


-(void)pararContagem{
    [self removeAllActions];
    
}


//CALCULA O TEMPO QUE DEMOROU PRO USUÁRIO RESPONDER
-(NSNumber*)calcularTempoDeResposta{
    float tempo = (self.size.width * tempoTotal) / widthSize;
    tempo = tempoTotal - tempo;
    
    NSNumber *tempoMedio = [NSNumber numberWithFloat:tempo];
    
    if(tempoMedio.floatValue == 0){
        tempoMedio = [NSNumber numberWithFloat:tempoTotal];
    }
    
    return tempoMedio;
}


//RETORNA A MÉDIA DE TEMPO DE RESPOSTA NO GERAL COM BASE NO VETOR DE MÉDIAS DE TEMPO
-(NSArray*)getVetorTempos{
    float tempoMedio = 0;
    
    for(int i=0; i<vtTempoDeResposta.count; i++){
        tempoMedio += [[vtTempoDeResposta objectAtIndex:i] floatValue];
    }
    
    return vtTempoDeResposta;
}

@end
