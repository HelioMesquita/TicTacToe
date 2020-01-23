//
//  UIWindow+TTWindow.h
//  TicTacToe
//
//  Created by Hélio Mesquita on 14/01/20.
//

#import "TicTacToeViewController.h"

@import UIKit;

@interface TicTacToeWindow : UIWindow

@property (nonatomic,strong) TicTacToeViewController * viewController;
@property (nonatomic,strong) UIView * superiorView;
@property (nonatomic,strong) UIView * inferiorView;

@end
