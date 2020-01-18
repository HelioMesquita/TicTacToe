//
//  UIWindow+TTWindow.m
//  TicTacToe
//
//  Created by Hélio Mesquita on 14/01/20.
//

#import "TTWindow.h"

@interface TTWindow ()

@end

@implementation TTWindow

- (instancetype)init {
    self = [super initWithFrame:UIScreen.mainScreen.bounds];
    if (self) {
        self.backgroundColor = nil;
        return self;
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.view != nil) {
        CGPoint viewPoint = [self convertPoint:point toView: self.view];
        return [self.view pointInside:viewPoint withEvent:event];
    } else {
        return false;
    }
}

@end
