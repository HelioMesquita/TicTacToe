//
//  UIViewController+TicTacToeViewController.h
//  TicTacToe
//
//  Created by Hélio Mesquita on 14/01/20.
//

#import "TTWindow.h"

@import UIKit;
@import MediaPlayer;
@import AVKit;

@interface TicTacToeViewController : UIViewController

@property (nonatomic,strong, nonnull) TTWindow * window;

- (void)configureVolumeView;
- (void)configureView;
- (void)addBaselines;
- (void)addHorizontal:(nonnull CGFloat *)lineSize lineSpacing:(nonnull CGFloat *)lineSpacing previuosBaseline:(nullable UIView*)previuosBaseline;
- (void)addVertical:(nonnull CGFloat *)lineSize lineSpacing:(nonnull CGFloat *)lineSpacing previuosBaseline:(nullable UIView*)previuosBaseline;

//- (void)addVertical:(CGFloat)lineSize, (CGFloat)lineSpacing, (nullable UIView*)previuosBaseline);

@end
