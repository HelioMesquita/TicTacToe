//
//  UIViewController+TicTacToeViewController.m
//  TicTacToe
//
//  Created by Hélio Mesquita on 14/01/20.
//

#import "TicTacToeViewController.h"

@interface TicTacToeViewController ()

@end

@implementation TicTacToeViewController

bool isVolumeControllerHidden = true;



- (instancetype)init {
    self = [super initWithNibName:nil bundle:nil];
    self.window = [[TTWindow alloc]init];
    self.window.windowLevel = UIWindowLevelAlert;
    [self.window setHidden:NO];
    self.window.rootViewController = self;
    [self.window setUserInteractionEnabled:YES];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureVolumeView];
    [self configureView];
    [self addBaselines];
}

- (void)addBaselines {
    CGFloat lineSize = 1;
    CGFloat lineSpacing = 4;
    [self addVertical: &lineSize lineSpacing: &lineSpacing previuosBaseline:nil];
    [self addHorizontal: &lineSize lineSpacing: &lineSpacing previuosBaseline:nil];
}

- (void)configureVolumeView {
    if (isVolumeControllerHidden) {
        MPVolumeView *volumeView = [[MPVolumeView alloc]initWithFrame: CGRectZero];
        for (UIView *subview in volumeView.subviews) {
            UIButton *button;
            if ([subview isKindOfClass:[UIButton class]]) {
                button = subview;
                [button setImage:nil forState:normal];
                [button setEnabled:false];
                [button sizeToFit];
            }
        }
        [UIApplication.sharedApplication.windows.firstObject addSubview:volumeView];
        [UIApplication.sharedApplication.windows.firstObject sendSubviewToBack:volumeView];
    }
}

- (void)configureView {
    self.view.backgroundColor = UIColor.clearColor;
    [self.view setUserInteractionEnabled:YES];
    self.window.view = self.view;
}

- (void)addHorizontal:(CGFloat *)lineSize lineSpacing:(CGFloat *)lineSpacing previuosBaseline:(UIView *)previuosBaseline {

}

- (void)addVertical:(CGFloat *)lineSize lineSpacing:(CGFloat *)lineSpacing previuosBaseline:(UIView *)previuosBaseline {

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[AVAudioSession sharedInstance] addObserver:self forKeyPath: @"outputVolume" options: NSKeyValueObservingOptionNew context:nil];
    [[AVAudioSession sharedInstance] setActive:true error:nil];

//    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&sessionError];

}

//override public func viewWillAppear(_ animated: Bool) {
//    super.viewWillAppear(animated)
//    AVAudioSession.sharedInstance().addObserver(self, forKeyPath: "outputVolume", options: NSKeyValueObservingOptions.new, context: nil)
//    do { try AVAudioSession.sharedInstance().setActive(true) }
//    catch { debugPrint("\(error)") }
//}
//
//override public func viewDidDisappear(_ animated: Bool) {
//    super.viewDidDisappear(animated)
//    AVAudioSession.sharedInstance().removeObserver(self, forKeyPath: "outputVolume")
//    do { try AVAudioSession.sharedInstance().setActive(false) }
//    catch { debugPrint("\(error)") }
//}



@end
