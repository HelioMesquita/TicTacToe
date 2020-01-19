//
//  UIWindow+TTWindow.h
//  TicTacToe
//
//  Created by Hélio Mesquita on 14/01/20.
//


#import "TapableView.h"

@import UIKit;

@interface CustomWindow : UIWindow

@property (nonatomic,strong) UIView * view;
@property (nonatomic,strong) TapableView * superiorTapView;
@property (nonatomic,strong) TapableView * inferiorTapView;

@end
