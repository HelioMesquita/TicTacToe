//
//  UIWindow+TTWindow.m
//  TicTacToe
//
//  Created by Hélio Mesquita on 14/01/20.
//

#import "CustomWindow.h"

@interface CustomWindow ()

@end

@implementation CustomWindow

- (instancetype)init {
    self = [super initWithFrame:UIScreen.mainScreen.bounds];
    if (self) {
        self.backgroundColor = nil;
        return self;
    }
    return self;
}

//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
////    if (self.view != nil) {
////        CGPoint viewPoint = [self convertPoint:point toView: self.view];
////        return [self.view pointInside:viewPoint withEvent:event];
////    } else {
//        return false;
////    }
//}

//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    for (UITouch *t in touches) {
//        NSLog(@"B: touch: %@", t);
//    }
//
//}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView * view = [super hitTest:point withEvent:event];
    if (CGRectContainsPoint(self.superiorTapView.frame, point)) {
        NSLog(@"click header");
        return self.superiorTapView;

//        for (UITouch *t in event.allTouches) {
//            NSLog(@"B: touch: %@", t);
//        }
    }

    if (CGRectContainsPoint(self.inferiorTapView.frame, point)) {
            NSLog(@"click footer");
            return self.inferiorTapView;

    //        for (UITouch *t in event.allTouches) {
    //            NSLog(@"B: touch: %@", t);
    //        }
        }
    return view == self ? nil : view;
}


@end
