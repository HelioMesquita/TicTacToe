//
//  NSObject+TicTacToePreferences.m
//  TicTacToe
//
//  Created by Hélio Mesquita on 22/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

#import "TicTacToePreferences.h"
#import "TicTacToeContainer.h"

@implementation TicTacToePreferences

TicTacToeContainer * container;

+ (TicTacToePreferences *)shared {
    static TicTacToePreferences *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

- (id)init {
    if (self = [super init]) {
        self.isUsingScenePattern = false;
    }
    return self;
}

- (void)show {
    container = [[TicTacToeContainer new]init];
    [container show];
}

- (void)remove {
    [container remove];
}

@end
