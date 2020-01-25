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
+ (TicTacToePreferences *) shared;

@property Boolean *isUsingScenePattern;
- (void)show;
- (void)remove;

@end
