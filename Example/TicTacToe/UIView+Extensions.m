//
//  UIView+Extensions.m
//  TicTacToe
//
//  Created by Hélio Mesquita on 14/01/20.
//

@implementation UIView(Extensions)

- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}

- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}

@end
