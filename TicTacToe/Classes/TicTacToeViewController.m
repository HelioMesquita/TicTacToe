//
//  UIViewController+TicTacToeViewController.m
//  TicTacToe
//
//  Created by Hélio Mesquita on 14/01/20.
//

#import "TicTacToeViewController.h"
#import "UIView+Extensions.h"

@interface TicTacToeViewController ()

@end

@implementation TicTacToeViewController

typedef enum {
    SPACING4,
    SPACING8,
    OFF
} Baseline;

bool isVolumeControllerHidden = true;
TTWindow * window;
Baseline currentBaseline = OFF;

NSMutableArray * horizontalBaselines;
NSMutableArray * horizontalSpacing;

NSMutableArray * verticalBaselines;
NSMutableArray * verticalSpacing;

CGFloat lineSize = 1;
CGFloat lineSpacing = 4;

- (instancetype)init {
    self = [super initWithNibName: nil bundle: nil];
    if (self) {
        window = [[TTWindow new]init];
        window.windowLevel = UIWindowLevelAlert; //window.windowLevel = UIWindow.Level(floatLiteral: .greatestFiniteMagnitude)
        window.view = self.view;
        [window setHidden:NO];
        [window setRootViewController: self];
        [window setUserInteractionEnabled:YES];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configure];
    [self addBaselines];
}

- (void)viewWillAppear:(BOOL)animated {
    AVAudioSession* audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:YES error:nil];
    [audioSession addObserver:self forKeyPath:@"outputVolume" options:0 context:nil];
}

- (void)configure {
    self.view.backgroundColor = UIColor.clearColor;
    [self.view setUserInteractionEnabled: NO];

    horizontalSpacing = [NSMutableArray array];
    horizontalBaselines = [NSMutableArray array];

    verticalSpacing = [NSMutableArray array];
    verticalBaselines = [NSMutableArray array];
}

- (void)addBaselines {
    [self addVertical: &lineSize lineSpacing: &lineSpacing previuosBaseline:nil];
    [self addHorizontal: &lineSize lineSpacing: &lineSpacing previuosBaseline:nil];
    [self setBaselineHidden:true];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath  isEqualToString: @"outputVolume"]) {
        [self handleBaseline];
    }
}

- (void)handleBaseline {
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

- (void)addHorizontal:(CGFloat *)lineSize lineSpacing:(CGFloat *)lineSpacing previuosBaseline:(UIView *)previuosBaseline {
    if (previuosBaseline != nil) {
        UIView *baseline = [self createBaselineAndAddView: UIColor.greenColor];
        NSLayoutConstraint *spacing = [baseline.topAnchor constraintEqualToAnchor:previuosBaseline.topAnchor constant:*lineSpacing];

        [horizontalBaselines addObject:baseline];
        [horizontalSpacing addObject:spacing];

        [NSLayoutConstraint activateConstraints:@[
            [baseline.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor],
            [baseline.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor],
            [baseline.heightAnchor constraintEqualToConstant: *lineSize],
            spacing
        ]
         ];

        [self.view layoutSubviews];
        if (baseline.maxY >= UIScreen.mainScreen.bounds.size.height) {
            return;
        } else {
            [self addHorizontal: lineSize lineSpacing: lineSpacing previuosBaseline: baseline];
        }

    } else {
        UIView *baseline = [self createBaselineAndAddView: UIColor.greenColor];
        [horizontalBaselines addObject:baseline];

        [NSLayoutConstraint activateConstraints:@[
            [baseline.topAnchor constraintEqualToAnchor: self.view.topAnchor],
            [baseline.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor],
            [baseline.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor],
            [baseline.heightAnchor constraintEqualToConstant: *lineSize]
        ]
         ];
        [self addHorizontal: lineSize lineSpacing: lineSpacing previuosBaseline: baseline];
    }
}

- (void)addVertical:(CGFloat *)lineSize lineSpacing:(CGFloat *)lineSpacing previuosBaseline:(UIView *)previuosBaseline {
    if (previuosBaseline != nil) {
        UIView *baseline = [self createBaselineAndAddView: UIColor.purpleColor];
        NSLayoutConstraint *spacing = [baseline.leadingAnchor constraintEqualToAnchor:previuosBaseline.leadingAnchor constant:*lineSpacing];

        [verticalBaselines addObject:baseline];
        [verticalSpacing addObject:spacing];

        [NSLayoutConstraint activateConstraints:@[
            [baseline.topAnchor constraintEqualToAnchor: self.view.topAnchor],
            [baseline.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor],
            [baseline.widthAnchor constraintEqualToConstant: *lineSize],
            spacing
        ]
         ];

        [self.view layoutSubviews];
        if (baseline.maxX >= UIScreen.mainScreen.bounds.size.width) {
            return;
        } else {
            [self addVertical: lineSize lineSpacing: lineSpacing previuosBaseline: baseline];
        }

    } else {
        UIView *baseline = [self createBaselineAndAddView: UIColor.purpleColor];
        [verticalBaselines addObject:baseline];

        [NSLayoutConstraint activateConstraints:@[
            [baseline.topAnchor constraintEqualToAnchor: self.view.topAnchor],
            [baseline.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor],
            [baseline.widthAnchor constraintEqualToConstant: *lineSize],
            [baseline.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor],
        ]
         ];
        [self addVertical: lineSize lineSpacing: lineSpacing previuosBaseline: baseline];
    }
}

- (nonnull UIView *)createBaselineAndAddView:(nonnull UIColor *)color {
    UIView *baseline = [[UIView alloc]init];
    baseline.translatesAutoresizingMaskIntoConstraints = false;
    baseline.backgroundColor = color;
    [baseline setUserInteractionEnabled:true];
    [self.view addSubview:baseline];
    [self.view sendSubviewToBack:baseline];
    return baseline;
}

@end
