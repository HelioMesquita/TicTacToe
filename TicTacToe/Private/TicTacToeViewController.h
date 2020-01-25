//
//  UIViewController+TicTacToeViewController.h
//  TicTacToe
//
//  Created by Hélio Mesquita on 14/01/20.
//

#import "TicTacToeGridView.h"
#import "TicTacToeActionsView.h"

@import UIKit;

@interface TicTacToeViewController : UIViewController

@property (nonatomic,strong) TicTacToeGridView * gridView;
@property (nonatomic,strong) TicTacToeActionsView * actionsView;

@end
