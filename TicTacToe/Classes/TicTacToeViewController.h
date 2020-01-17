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

typedef enum {
    on,
    baseline4,
    off
} Status;

@property (nonatomic, strong, nonnull) TTWindow * window;
@property (nonatomic, strong, nonnull) NSMutableArray * horizontalSpacing;
@property (nonatomic, strong, nonnull) NSMutableArray * horizontalBaselines;
@property (nonatomic, strong, nonnull) NSMutableArray * verticalSpacing;
@property (nonatomic, strong, nonnull) NSMutableArray * verticalBaselines;

//    private var horizontalBaselines: [UIView] = []
//    private var horizontalSpacing: [NSLayoutConstraint] = []

//- (void)configureVolumeView;
//- (void)configureView;
//- (void)addBaselines;
//- (void)addHorizontal:(nonnull CGFloat *)lineSize lineSpacing:(nonnull CGFloat *)lineSpacing previuosBaseline:(nullable UIView*)previuosBaseline;
//- (void)addVertical:(nonnull CGFloat *)lineSize lineSpacing:(nonnull CGFloat *)lineSpacing previuosBaseline:(nullable UIView*)previuosBaseline;
//createBaselineAndAddView(_ color: UIColor) -> UIView

//- (void)addVertical:(CGFloat)lineSize, (CGFloat)lineSpacing, (nullable UIView*)previuosBaseline);

@end
