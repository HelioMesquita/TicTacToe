//
//  NewWindow.swift
//  TicTacToeExample
//
//  Created by Hélio Mesquita on 20/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import UIKit

class NewWindow: UIWindow {

    var timer: Timer?
    var clicks: [UIView] = []
    var superiorView: UIView?
    var inferiorView: UIView?

    override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
        frame = UIScreen.main.bounds
    }

    init() {
        super.init(frame: UIScreen.main.bounds)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if timer == nil {
            timer = Timer(timeInterval: 0.1, target: self, selector: #selector(timerFired), userInfo: nil, repeats: false)
        }

        let view = super.hitTest(point, with: event)
//        if inferiorView!.bounds.contains(view!.frame) {
//            clicks.append(inferiorView!)
//        }
//        if superiorView!.bounds.contains(view!.frame) {
//            clicks.append(superiorView!)
//        }


        return view == self ? nil : view
    }

    @objc func timerFired() {
        if clicks.count == 2 {
//            [self.viewController handleTouchEvent];
        }
        clicks.removeAll()
        timer?.invalidate()
        timer = nil;
    }
}

//
//  UIWindow+TTWindow.m
//  TicTacToe
//
//  Created by Hélio Mesquita on 14/01/20.
//

//#import "TicTaeToeWindow.h"
//
//@interface TicTaeToeWindow ()
//
//@end
//
//@implementation TicTaeToeWindow
//
//NSTimer *timer;
//NSMutableArray * clicks;
//
//- (instancetype)init {
//    self = [super initWithFrame:UIScreen.mainScreen.bounds];
//    if (self) {
//        self.backgroundColor = nil;
//        clicks = [NSMutableArray array];
//        return self;
//    }
//    return self;
//}
//
//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    if (timer == nil) {
//        timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerFired) userInfo:nil repeats:false];
//    }
//
//    UIView * view = [super hitTest:point withEvent:event];
//    if (CGRectContainsPoint(self.superiorView.frame, point)) {
//        [clicks addObject:self.superiorView];
//    }
//
//    if (CGRectContainsPoint(self.inferiorView.frame, point)) {
//        [clicks addObject:self.inferiorView];
//    }
//    return view == self ? nil : view;
//}
//
//-(void)timerFired {
//    if (clicks.count == 2) {
//        [self.viewController handleTouchEvent];
//    }
//    [clicks removeAllObjects];
//    [timer invalidate];
//    timer = nil;
//}
//
//@end
