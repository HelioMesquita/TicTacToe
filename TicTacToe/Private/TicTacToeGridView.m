//
//  TicTacToeGridView.m
//  TicTacToe
//
//  Created by Hélio Mesquita on 23/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//


#import "TicTacToeGridView.h"

@interface TicTacToeGridView ()

@end

@implementation TicTacToeGridView

typedef enum {
    SPACING4,
    SPACING8,
    OFF
} Baseline;


Baseline currentBaseline = OFF;
CGFloat lineSize = 1;
CGFloat lineSpacing = 4;

UIColor * horizontalColor;
UIColor * verticalColor;
NSMutableArray * horizontalBaselines;
NSMutableArray * horizontalSpacing;
NSMutableArray * verticalBaselines;
NSMutableArray * verticalSpacing;

- (instancetype)init
{
    self = [super initWithFrame:UIScreen.mainScreen.bounds];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = false;
    }
    return self;
}

- (void)configure {
    [self configureView];
    [self addBaselines];
    [self setBaselineHidden:true];
}

-(void) configureView {
    [self setBackgroundColor: UIColor.clearColor];
    [self setUserInteractionEnabled:false];

    horizontalSpacing = [NSMutableArray array];
    horizontalBaselines = [NSMutableArray array];
    verticalSpacing = [NSMutableArray array];
    verticalBaselines = [NSMutableArray array];
    verticalColor = [UIColor.greenColor colorWithAlphaComponent:0.3];
    horizontalColor = [UIColor.purpleColor colorWithAlphaComponent:0.3];
}

-(void) addBaselines {
    [self startBaselineVertical];
    [self startBaselineHorizontal];
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

-(void) startBaselineVertical {
    int numberOfDivisions = (int)UIScreen.mainScreen.bounds.size.width/lineSpacing;

    UIView * firstBaseline = [self createView: verticalColor];
    [verticalBaselines addObject:firstBaseline];

    [NSLayoutConstraint activateConstraints:@[
        [firstBaseline.topAnchor constraintEqualToAnchor: self.topAnchor],
        [firstBaseline.bottomAnchor constraintEqualToAnchor: self.bottomAnchor],
        [firstBaseline.leadingAnchor constraintEqualToAnchor: self.leadingAnchor],
        [firstBaseline.widthAnchor constraintEqualToConstant: lineSize],
    ]
     ];

    for (int i = 1; i <= numberOfDivisions; i++) {
        UIView * previuosBaseline = verticalBaselines.lastObject;
        UIView * baseline = [self createView:verticalColor];
        NSLayoutConstraint * spacing = [baseline.leadingAnchor constraintEqualToAnchor:previuosBaseline.trailingAnchor constant:lineSpacing];

        [verticalBaselines addObject:baseline];
        [verticalSpacing addObject:spacing];

        [NSLayoutConstraint activateConstraints:@[
            [baseline.topAnchor constraintEqualToAnchor: self.topAnchor],
            [baseline.bottomAnchor constraintEqualToAnchor: self.bottomAnchor],
            [baseline.widthAnchor constraintEqualToConstant: lineSize],
            spacing
        ]
         ];
    }
    [self layoutSubviews];
}

-(void) startBaselineHorizontal {
    int numberOfDivisions = (int)UIScreen.mainScreen.bounds.size.height/lineSpacing;

    UIView * firstBaseline = [self createView: horizontalColor];
    [horizontalBaselines addObject:firstBaseline];

    [NSLayoutConstraint activateConstraints:@[
        [firstBaseline.topAnchor constraintEqualToAnchor: self.topAnchor],
        [firstBaseline.trailingAnchor constraintEqualToAnchor: self.trailingAnchor],
        [firstBaseline.leadingAnchor constraintEqualToAnchor: self.leadingAnchor],
        [firstBaseline.heightAnchor constraintEqualToConstant: lineSize],
    ]
     ];

    for (int i = 1; i <= numberOfDivisions; i++) {
        UIView * previuosBaseline = horizontalBaselines.lastObject;
        UIView * baseline = [self createView:horizontalColor];
        NSLayoutConstraint * spacing = [baseline.topAnchor constraintEqualToAnchor:previuosBaseline.bottomAnchor constant:lineSpacing];

        [horizontalBaselines addObject:baseline];
        [horizontalSpacing addObject:spacing];

        [NSLayoutConstraint activateConstraints:@[
            spacing,
            [baseline.trailingAnchor constraintEqualToAnchor: self.trailingAnchor],
            [baseline.leadingAnchor constraintEqualToAnchor: self.leadingAnchor],
            [baseline.heightAnchor constraintEqualToConstant: lineSize],
        ]
         ];
    }
    [self layoutSubviews];
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

- (nonnull UIView *)createView:(nonnull UIColor *)color {
    UIView *baseline = [[UIView alloc]init];
    baseline.translatesAutoresizingMaskIntoConstraints = false;
    baseline.backgroundColor = color;
    [baseline setUserInteractionEnabled:true];
    [self addSubview:baseline];
    [self sendSubviewToBack:baseline];
    return baseline;
}

@end
