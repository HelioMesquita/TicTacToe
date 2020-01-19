//
//  UIView+TapableView.m
//  TicTacToe
//
//  Created by Hélio Mesquita on 19/01/20.
//

#import "CustomGesture.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface CustomGesture ()
@end

@implementation CustomGesture : UIGestureRecognizer

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (touches.count < 2) //
    {
        self.state = UIGestureRecognizerStateFailed; //This makes sure there is not a two or more finger touch.  Multiple finger touch is something you can do though!
        return;
    }
}


@end
