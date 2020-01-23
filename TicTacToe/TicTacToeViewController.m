//
//  UIViewController+TicTacToeViewController.m
//  TicTacToe
//
//  Created by Hélio Mesquita on 14/01/20.
//

#import "TicTacToeViewController.h"
#import "TicTacToeWindow.h"

@interface TicTacToeViewController ()

@end

@implementation TicTacToeViewController

typedef enum {
    SPACING4,
    SPACING8,
    OFF
} Baseline;

TicTacToeWindow * window;
UIView * superiorView;
UIView * inferiorView;

Baseline currentBaseline = OFF;
CGFloat lineSize = 1;
CGFloat lineSpacing = 4;
CGFloat touchAreaHeight = 80;

UIColor * horizontalColor;
UIColor * verticalColor;
NSMutableArray * horizontalBaselines;
NSMutableArray * horizontalSpacing;
NSMutableArray * verticalBaselines;
NSMutableArray * verticalSpacing;

- (instancetype)init {
    self = [super initWithNibName: nil bundle: nil];
    if (self) {
        window = [[TicTacToeWindow new]init];
        window.windowLevel = UIWindowLevelStatusBar+1;
        [window setHidden:NO];
        [window setRootViewController: self];
        [window setUserInteractionEnabled:YES];
        [window makeKeyAndVisible];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
    [self addBaselines];
    [self addSuperiorTapView];
    [self addInferiorTapView];
}

- (void)configureView {
    self.view.backgroundColor = UIColor.clearColor;
    [self.view setUserInteractionEnabled: NO];
    window.viewController = self;

    horizontalSpacing = [NSMutableArray array];
    horizontalBaselines = [NSMutableArray array];
    verticalSpacing = [NSMutableArray array];
    verticalBaselines = [NSMutableArray array];
}

- (void)addBaselines {
    [self startBaselineVertical];
    [self startBaselineHorizontal];
    [self setBaselineHidden:true];
}

- (void)startBaselineVertical {
    verticalColor = [UIColor.greenColor colorWithAlphaComponent:0.3];
    UIView * firstBaselineVertical = [self createView: verticalColor];
    [verticalBaselines addObject: firstBaselineVertical];
    [NSLayoutConstraint activateConstraints:@[
        [firstBaselineVertical.topAnchor constraintEqualToAnchor: self.view.topAnchor],
        [firstBaselineVertical.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor],
        [firstBaselineVertical.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor],
        [firstBaselineVertical.widthAnchor constraintEqualToConstant: lineSize],
    ]
     ];
    [self addVertical: firstBaselineVertical];
}

- (void)startBaselineHorizontal {
    horizontalColor = [UIColor.purpleColor colorWithAlphaComponent:0.3];
    UIView * firstBaselineHorizontal = [self createView: horizontalColor];
    [horizontalBaselines addObject:firstBaselineHorizontal];
    [NSLayoutConstraint activateConstraints:@[
        [firstBaselineHorizontal.topAnchor constraintEqualToAnchor: self.view.topAnchor],
        [firstBaselineHorizontal.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor],
        [firstBaselineHorizontal.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor],
        [firstBaselineHorizontal.heightAnchor constraintEqualToConstant: lineSize]
    ]
     ];
    [self addHorizontal:firstBaselineHorizontal];
}

- (void)addSuperiorTapView {
    superiorView = [self createView:UIColor.clearColor];
    window.superiorView = superiorView;
    [NSLayoutConstraint activateConstraints:@[
        [superiorView.topAnchor constraintEqualToAnchor: self.view.topAnchor],
        [superiorView.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor],
        [superiorView.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor],
        [superiorView.heightAnchor constraintEqualToConstant: touchAreaHeight]
    ]
     ];
}

- (void)addInferiorTapView {
    inferiorView = [self createView:UIColor.clearColor];
    window.inferiorView = inferiorView;
    [NSLayoutConstraint activateConstraints:@[
        [inferiorView.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor],
        [inferiorView.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor],
        [inferiorView.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor],
        [inferiorView.heightAnchor constraintEqualToConstant: touchAreaHeight]
    ]
     ];
}

- (void)handleTouchEvent {
    switch (currentBaseline) {
        case SPACING4:
            currentBaseline = SPACING8;
            [self setBaselineHidden:false];
            [self setBaselineSpacing:8];
            break;
        case SPACING8:
            currentBaseline = OFF;
            [self setBaselineHidden:true];
            break;
        case OFF:
            currentBaseline = SPACING4;
            [self setBaselineHidden:false];
            [self setBaselineSpacing:4];
            break;
    }
}

- (void)setBaselineSpacing:(CGFloat)value {
    for (NSLayoutConstraint *constraint in verticalSpacing) {
        [constraint setConstant:value];
    }

    for (NSLayoutConstraint *constraint in horizontalSpacing) {
        [constraint setConstant:value];
    }
}

- (void)setBaselineHidden:(BOOL)hidden {
    for (UIView *subview in verticalBaselines) {
        [subview setHidden:hidden];
    }

    for (UIView *subview in horizontalBaselines) {
        [subview setHidden:hidden];
    }
}

- (void)addHorizontal:(nonnull UIView *)previuosBaseline {
        UIView *baseline = [self createView: horizontalColor];
        NSLayoutConstraint *spacing = [baseline.topAnchor constraintEqualToAnchor:previuosBaseline.topAnchor constant:lineSpacing];

        [horizontalBaselines addObject:baseline];
        [horizontalSpacing addObject:spacing];

        [NSLayoutConstraint activateConstraints:@[
            [baseline.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor],
            [baseline.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor],
            [baseline.heightAnchor constraintEqualToConstant: lineSize],
            spacing
        ]
         ];

        [self.view layoutSubviews];
        CGFloat maxY = CGRectGetMaxY(baseline.frame);
        if (maxY >= UIScreen.mainScreen.bounds.size.height) {
            return;
        } else {
            [self addHorizontal:baseline];
        }
}

- (void)addVertical:(nonnull UIView *)previuosBaseline {
        UIView *baseline = [self createView: verticalColor];
        NSLayoutConstraint *spacing = [baseline.leadingAnchor constraintEqualToAnchor:previuosBaseline.leadingAnchor constant:lineSpacing];

        [verticalBaselines addObject:baseline];
        [verticalSpacing addObject:spacing];

        [NSLayoutConstraint activateConstraints:@[
            [baseline.topAnchor constraintEqualToAnchor: self.view.topAnchor],
            [baseline.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor],
            [baseline.widthAnchor constraintEqualToConstant: lineSize],
            spacing
        ]
         ];

        [self.view layoutSubviews];
        CGFloat maxX = CGRectGetMaxX(baseline.frame);
        if (maxX >= UIScreen.mainScreen.bounds.size.width) {
            return;
        } else {
            [self addVertical:baseline];
        }
}

- (nonnull UIView *)createView:(nonnull UIColor *)color {
    UIView *baseline = [[UIView alloc]init];
    baseline.translatesAutoresizingMaskIntoConstraints = false;
    baseline.backgroundColor = color;
    [baseline setUserInteractionEnabled:true];
    [self.view addSubview:baseline];
    [self.view sendSubviewToBack:baseline];
    return baseline;
}

@end
