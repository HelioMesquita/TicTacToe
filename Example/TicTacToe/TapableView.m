//
//  UIView+TapableView.m
//  TicTacToe
//
//  Created by Hélio Mesquita on 19/01/20.
//

#import "TapableView.h"

@interface TapableView ()

@end

@implementation TapableView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUserInteractionEnabled:true];
    self.backgroundColor = UIColor.redColor;
}


@end
