//
//  UIViewController+TicTacToeViewController.m
//  TicTacToe
//
//  Created by Hélio Mesquita on 14/01/20.
//

#import "TicTacToeViewController.h"

@interface TicTacToeViewController ()

@end

@implementation TicTacToeViewController

- (instancetype)init {
    self.gridView = [[TicTacToeGridView new]init];
    self.actionsView = [[TicTacToeActionsView new]init];
    self = [super init];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.gridView];
    [self.view addSubview:self.actionsView];
    [NSLayoutConstraint activateConstraints:@[
        [self.gridView.topAnchor constraintEqualToAnchor: self.view.topAnchor],
        [self.gridView.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor],
        [self.gridView.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor],
        [self.gridView.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor],

        [self.actionsView.topAnchor constraintEqualToAnchor: self.view.topAnchor],
        [self.actionsView.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor],
        [self.actionsView.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor],
        [self.actionsView.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor],
    ]
     ];
}

@end
