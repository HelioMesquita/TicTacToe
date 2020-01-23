//
//  UIViewController+TicTacToeContainer.m
//  TicTacToe
//
//  Created by Hélio Mesquita on 22/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

@import UIKit;

#import "TicTacToeContainer.h"
#import "TicTacToeWindow.h"
#import "TicTacToePreferences.h"

@interface TicTacToeContainer ()

@end

@implementation TicTacToeContainer

UIWindow * normalWindow;
TicTacToeWindow * popupWindow;
TicTacToeViewController * childViewController;

- (instancetype)init {
    normalWindow = UIApplication.sharedApplication.windows.lastObject;
    childViewController = [[TicTacToeViewController new]init];
    self = [super init];
    [self setupViewController];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor: UIColor.clearColor];
}

- (void)setupViewController {
    [self addChildViewController:childViewController];
    childViewController.view.frame = UIScreen.mainScreen.bounds;
    [self.view addSubview:childViewController.view];
}

- (void) makeSelfKeyWindow {
    popupWindow = [self getWindow];
    popupWindow.frame = UIScreen.mainScreen.bounds;
    [popupWindow setBackgroundColor: UIColor.clearColor];
    popupWindow.windowLevel = UIWindowLevelAlert + 1;
    [popupWindow setRootViewController:self];
    [popupWindow makeKeyAndVisible];
    popupWindow.inferiorView = childViewController.actionsView.inferiorView;
    popupWindow.superiorView = childViewController.actionsView.superiorView;
}

- (TicTacToeWindow *) getWindow {
    if (TicTacToePreferences.shared.isUsingScenePattern) {
        if (@available(iOS 13.0, *)) {
            NSArray * scenes = UIApplication.sharedApplication.connectedScenes.allObjects;
            for (UIScene *scene in scenes) {
                if (scene.activationState == UISceneActivationStateForegroundActive) {
                    UIWindowScene *windowScene = (UIWindowScene *)scene;
                    return TicTacToeWindow(windowScene: windowScene);
                }
            }
        } else {
            return [[TicTacToeWindow new]init];
        }

    }
    return [[TicTacToeWindow new]init];

}

- (void)show {
    if (popupWindow == nil) {
        [self makeSelfKeyWindow];
        [childViewController didMoveToParentViewController:self];
    }
}

- (void)remove {
    popupWindow.rootViewController = nil;
    popupWindow = nil;
    [normalWindow makeKeyAndVisible];
}

@end
