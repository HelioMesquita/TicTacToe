#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "TicTacToeViewController.h"
#import "TicTacToeWindow.h"
#import "UIView+Extensions.h"

FOUNDATION_EXPORT double TicTacToeVersionNumber;
FOUNDATION_EXPORT const unsigned char TicTacToeVersionString[];

