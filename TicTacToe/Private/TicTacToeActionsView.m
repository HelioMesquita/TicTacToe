//
//  TicTacToeGridView.m
//  TicTacToe
//
//  Created by Hélio Mesquita on 23/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//


#import "TicTacToeActionsView.h"

@interface TicTacToeActionsView ()

@end

@implementation TicTacToeActionsView

CGFloat touchAreaHeight = 80;

- (instancetype)init
{
    self = [super initWithFrame:UIScreen.mainScreen.bounds];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = false;
    }
    return self;
}

-(void)configure {
    [self addSuperiorTapView];
    [self addInferiorTapView];
}

-(void) addSuperiorTapView {
    UIView * superiorView = [self createView:UIColor.clearColor];
    self.superiorView = superiorView;
    [NSLayoutConstraint activateConstraints:@[
         [superiorView.topAnchor constraintEqualToAnchor: self.topAnchor],
         [superiorView.trailingAnchor constraintEqualToAnchor: self.trailingAnchor],
         [superiorView.leadingAnchor constraintEqualToAnchor: self.leadingAnchor],
         [superiorView.heightAnchor constraintEqualToConstant:touchAreaHeight]
     ]
      ];
}

-(void) addInferiorTapView {
    UIView * inferiorView = [self createView:UIColor.clearColor];
    self.inferiorView = inferiorView;
    [NSLayoutConstraint activateConstraints:@[
        [inferiorView.bottomAnchor constraintEqualToAnchor: self.bottomAnchor],
        [inferiorView.trailingAnchor constraintEqualToAnchor: self.trailingAnchor],
        [inferiorView.leadingAnchor constraintEqualToAnchor: self.leadingAnchor],
        [inferiorView.heightAnchor constraintEqualToConstant:touchAreaHeight]
    ]
     ];
}

- (nonnull UIView *)createView:(nonnull UIColor *)color {
    UIView * touchView = [[UIView alloc]init];
    touchView.translatesAutoresizingMaskIntoConstraints = false;
    touchView.backgroundColor = color;
    [touchView setUserInteractionEnabled:true];
    [self addSubview: touchView];
    [self sendSubviewToBack: touchView];
    return  touchView;
}

@end
