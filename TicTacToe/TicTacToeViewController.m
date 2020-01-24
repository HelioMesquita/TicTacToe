//
//  UIViewController+TicTacToeViewController.m
//  TicTacToe
//
//  Created by Hélio Mesquita on 14/01/20.
//

#import "TicTacToeViewController.h"
#import "TicTacToeGridView.h"

@interface TicTacToeViewController ()

@end

@implementation TicTacToeViewController

TicTacToeGridView * gridView;
TicTacToeActionsView * actionsView;

- (instancetype)init {
    gridView = [[TicTacToeGridView new]init];
    actionsView = [[TicTacToeActionsView new]init];
    self = [super init];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:gridView];
    [self.view addSubview:actionsView];
    [NSLayoutConstraint activateConstraints:@[
        [gridView.topAnchor constraintEqualToAnchor: self.view.topAnchor],
        [gridView.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor],
        [gridView.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor],
        [gridView.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor],

        [actionsView.topAnchor constraintEqualToAnchor: self.view.topAnchor],
        [actionsView.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor],
        [actionsView.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor],
        [actionsView.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor],
    ]
     ];
}

@end
