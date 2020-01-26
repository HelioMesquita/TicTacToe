//
//  NSObject+TicTacToePreferences.h
//  TicTacToe
//
//  Created by Hélio Mesquita on 22/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

@import Foundation;

@interface TicTacToePreferences : NSObject {
}
+ (TicTacToePreferences * _Nonnull) shared;


@property bool isUsingScenePattern;

- (void)show;
- (void)remove;

@end
