//
//  UIWindow+TTWindow.m
//  TicTacToe
//
//  Created by Hélio Mesquita on 14/01/20.
//

#import "TicTaeToeWindow.h"

@interface TicTaeToeWindow ()

@end

@implementation TicTaeToeWindow

NSTimer *timer;
NSMutableArray * clicks;

- (instancetype)init {
    self = [super initWithFrame:UIScreen.mainScreen.bounds];
    if (self) {
        self.backgroundColor = nil;
        clicks = [NSMutableArray array];
        return self;
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (timer == nil) {
        timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerFired) userInfo:nil repeats:false];
    }

    UIView * view = [super hitTest:point withEvent:event];
    if (CGRectContainsPoint(self.superiorView.frame, point)) {
        [clicks addObject:self.superiorView];
    }

    if (CGRectContainsPoint(self.inferiorView.frame, point)) {
        [clicks addObject:self.inferiorView];
    }
    return view == self ? nil : view;
}

-(void)timerFired {
    if (clicks.count == 2) {
        [self.viewController handleTouchEvent];
    }
    [clicks removeAllObjects];
    [timer invalidate];
    timer = nil;
}

@end
