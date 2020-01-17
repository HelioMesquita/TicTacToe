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

- (Status)next:(nonnull Status *)status {

    if (status == on) {
        return baseline4;
    }

    if (status == off) {
        return on;
    }

    return baseline4;
}


bool isVolumeControllerHidden = true;
TTWindow * window;
Status currentStatus = off;

NSMutableArray * horizontalBaselines;
NSMutableArray * horizontalSpacing;

NSMutableArray * verticalBaselines;
NSMutableArray * verticalSpacing;

CGFloat lineSize = 1;
CGFloat lineSpacing = 4;

- (instancetype)init {
    self = [super initWithNibName: nil bundle: nil];
    if (self) {
        self.window = [[TTWindow new]init];
        self.window.windowLevel = UIWindowLevelAlert;
        [self.window setHidden:NO];
        self.window.rootViewController = self;
        [self.window setUserInteractionEnabled:YES];


        self.horizontalSpacing = [NSMutableArray new];
        self.horizontalBaselines = [NSMutableArray new];

        self.verticalSpacing = [NSMutableArray new];
        self.verticalBaselines = [NSMutableArray new];

        self.window = [TTWindow new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureVolumeView];
    [self configureView];
    [self addBaselines];
}

- (void)configureView {
    self.view.backgroundColor = UIColor.clearColor;
    [self.view setUserInteractionEnabled:YES];
    self.window.view = self.view;
}

- (void)addBaselines {
    [self addVertical: &lineSize lineSpacing: &lineSpacing previuosBaseline:nil];
    [self addHorizontal: &lineSize lineSpacing: &lineSpacing previuosBaseline:nil];
}

- (void)configureVolumeView {
    if (isVolumeControllerHidden) {
        MPVolumeView *volumeView = [[MPVolumeView alloc]initWithFrame: CGRectZero];
        for (UIView *subview in volumeView.subviews) {
            UIButton *button;
            if ([subview isKindOfClass:[UIButton class]]) {
                // guard let button = subview as? UIButton else { continue }
                // button.setImage(nil, for: .normal)
                // button.isEnabled = false
                // button.sizeToFit()

                // button = ((UIButton*)subview);
                //                [button setImage:nil forState:normal];
                //                [button setEnabled:false];
                //                [button sizeToFit];
            }
        }
        [UIApplication.sharedApplication.windows.firstObject addSubview:volumeView];
        [UIApplication.sharedApplication.windows.firstObject sendSubviewToBack:volumeView];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (keyPath == @"outputVolume") {
        Status nextStatus = [self next:currentStatus];
        if (nextStatus == on) {


            for (UIView *subview in verticalBaselines) {
                [subview setHidden:false];
            }

            for (UIView *subview in horizontalBaselines) {
                [subview setHidden:false];
            }

            for (NSLayoutConstraint *constraint in verticalSpacing) {
                [constraint setConstant:4];
            }

            for (NSLayoutConstraint *constraint in horizontalSpacing) {
                [constraint setConstant:4];
            }

        } else if (nextStatus == baseline4) {
            for (NSLayoutConstraint *constraint in verticalSpacing) {
                [constraint setConstant:8];
            }

            for (NSLayoutConstraint *constraint in horizontalSpacing) {
                [constraint setConstant:8];
            }

        } else {
            for (UIView *subview in verticalBaselines) {
                [subview setHidden:true];
            }

            for (UIView *subview in horizontalBaselines) {
                [subview setHidden:true];
            }
        }
        currentStatus = nextStatus;
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[AVAudioSession sharedInstance] addObserver:self forKeyPath: @"outputVolume" options: NSKeyValueObservingOptionNew context:nil];
    [[AVAudioSession sharedInstance] setActive:true error:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[AVAudioSession sharedInstance] addObserver:self forKeyPath: @"outputVolume" options: NSKeyValueObservingOptionNew context:nil];
    [[AVAudioSession sharedInstance] setActive:false error:nil];
}

- (nonnull UIView *)createBaselineAndAddView:(nonnull UIColor *)color {
    UIView *baseline = [self createBaselineAndAddView: color];
    [self addAndSendToBack: baseline];
    return baseline;
}

- (nonnull UIView *)createBaselineView:(nonnull UIColor *)color {
    UIView *baseline = [[UIView alloc]init];
    baseline.translatesAutoresizingMaskIntoConstraints = false;
    baseline.backgroundColor = color;
    [baseline setUserInteractionEnabled:true];
    return baseline;
}

- (void) addAndSendToBack:(nonnull UIView *)baseline {
    [self.view addSubview:baseline];
    [self.view sendSubviewToBack:baseline];
}

@end
