//
//  TTViewController.m
//  TicTacToe
//
//  Created by Helio Mesquita on 01/14/2020.
//  Copyright (c) 2020 Helio Mesquita. All rights reserved.
//

#import "TTViewController.h"
#import "TicTacToeViewController.h"

@interface TTViewController ()

@end

@implementation TTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[TicTacToeViewController alloc]init];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
