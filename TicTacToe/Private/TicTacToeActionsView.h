//
//  UIView+TicTacToeGridView.h
//  TicTacToe
//
//  Created by Hélio Mesquita on 23/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

@import UIKit;

@interface TicTacToeActionsView : UIView

@property (nonatomic,strong) UIView * superiorView;
@property (nonatomic,strong) UIView * inferiorView;

- (void)configure;

@end

