//
//  ListaDeExerciciosViewController.m
//  ProjetoFinal
//
//  Created by Rafael Aparecido de Freitas on 13/07/14.
//  Copyright (c) 2014 SENAC - iOS. All rights reserved.
//

#import "ListaDeExerciciosViewController.h"

@interface ListaDeExerciciosViewController ()

@end

@implementation ListaDeExerciciosViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    gerenciador = [GerenciadorDeAssunto sharedGerenciador];
    [gerenciador preparaExercicios];
    titulosEDescricoes = [gerenciador retornaTitulosEDescricoesExercicios];
    
    [[self navigationItem] setTitle:[NSString stringWithFormat:@"Exercícios %@", [gerenciador retornaNomeAssuntoAtual]]];
    
    [myTableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    cell.textLabel.text = [[titulosEDescricoes objectAtIndex:indexPath.row]valueForKey:@"titulo"];
    cell.detailTextLabel.text = [[titulosEDescricoes objectAtIndex:indexPath.row]valueForKey:@"descricao"];
    
    //VERIFICA SE A O EXERCÍCIO DA LINHA SELECIONADA FOI COMPLETADO PARA INSERIR OU NÃO A IMAGEM
    if([self verificarExercicioCompleto:(int)indexPath.row]){
        UIImageView* imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"check.png"]];
        [imageView setFrame:CGRectMake(cell.frame.size.width - 50, 15, 35, 35)];
        [cell addSubview:imageView];
    }
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [titulosEDescricoes count];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    txtDescricao.text = [[titulosEDescricoes objectAtIndex:indexPath.row]valueForKey:@"descricao"];
    

    [btnExercitar setHidden:NO];
    
    //VERIFICA SE A O EXERCÍCIO DA LINHA SELECIONADA FOI COMPLETADO PARA DEFINIR O TEXTO CORRETO
    if([self verificarExercicioCompleto:(int)indexPath.row]){
        [btnExercitar setTitle:@"Refazer" forState:UIControlStateNormal];
    
    }else{
        [btnExercitar setTitle:@"Iniciar" forState:UIControlStateNormal];
    }
    
    [gerenciador selecionaExercicio:(int)indexPath.row];
    
}


- (IBAction)btnExercitarAction:(id)sender {

    
    // Instancia somente o exercício clicado pelo usuário para que na proxima view ele esteja pronto para ser exibido
    

}

-(BOOL)verificarExercicioCompleto:(int)index{
    return [[[titulosEDescricoes objectAtIndex:index]objectForKey:@"exercicio"]verificaFinalizado];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

@end
