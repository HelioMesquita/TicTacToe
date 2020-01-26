//
//  UIWindow+TTWindow.m
//  TicTacToe
//
//  Created by Hélio Mesquita on 14/01/20.
//

#import "TicTacToeWindow.h"

@interface TicTacToeWindow ()

@end

@implementation TicTacToeWindow

NSTimer *timer;
NSMutableArray * taps;


- (instancetype)initWithWindowScene:(UIWindowScene *)windowScene {
    self = [super initWithWindowScene:windowScene];
    self.frame = UIScreen.mainScreen.bounds;
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        taps = [NSMutableArray array];
        return self;
    }
    return self;
}

- (instancetype)init {
    self = [super initWithFrame:UIScreen.mainScreen.bounds];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        taps = [NSMutableArray array];
        return self;
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (timer == nil) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerFired) userInfo:nil repeats:false];
    }

    UIView * view = [super hitTest:point withEvent:event];
    if (CGRectContainsPoint(self.superiorView.frame, point)) {
        NSLog(@"superior");
        [taps addObject:self.superiorView];
    }

    if (CGRectContainsPoint(self.inferiorView.frame, point)) {
        NSLog(@"inferior");
        [taps addObject:self.inferiorView];
    }
    return view == self ? nil : view;
}

-(void)timerFired {
    if (taps.count == 2) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"didChangeBaseline" object:nil];
    }
    [taps removeAllObjects];
    [timer invalidate];
    timer = nil;
}

@end
