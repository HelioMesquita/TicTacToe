//
//private class PopupViewController: UIViewController {
//
//    //    Baseline currentBaseline = OFF;
//    let lineSize: CGFloat = 1;
//    let lineSpacing: CGFloat = 4;
//    let touchAreaHeight: CGFloat = 80;
//
//    var horizontalBaselines: [UIView] = []
//    var horizontalSpacing: [NSLayoutConstraint] = []
//    var verticalBaselines: [UIView] = []
//    var verticalSpacing: [NSLayoutConstraint] = []
//
//    public init() {
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureView()
//        addBaselines()
//        //        addSuperiorTapView()
//        //        addInferiorTapView()
//    }
//
//    func configureView() {
//        self.view.backgroundColor = UIColor.clear
//        self.view.isUserInteractionEnabled = false
//    }
//
//    func addBaselines() {
//        startBaselineVertical()
//        startBaselineHorizontal()
//        setBaselineHidden(true)
//    }
//
//    func startBaselineVertical() {
//        let verticalColor = UIColor.green.withAlphaComponent(0.3)
//        let firstBaselineVertical = createView(verticalColor)
//        verticalBaselines.append(firstBaselineVertical)
//        NSLayoutConstraint.activate([
//            firstBaselineVertical.topAnchor.constraint(equalTo: self.view.topAnchor),
//            firstBaselineVertical.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
//            firstBaselineVertical.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            firstBaselineVertical.widthAnchor.constraint(equalToConstant: lineSize)
//        ])
//        addVertical(firstBaselineVertical)
//    }
//
//    func startBaselineHorizontal() {
//        let horizontalColor = UIColor.purple.withAlphaComponent(0.3)
//        let firstBaselineHorizontal = createView(horizontalColor)
//        horizontalBaselines.append(firstBaselineHorizontal)
//        NSLayoutConstraint.activate([
//            firstBaselineHorizontal.topAnchor.constraint(equalTo: self.view.topAnchor),
//            firstBaselineHorizontal.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            firstBaselineHorizontal.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            firstBaselineHorizontal.heightAnchor.constraint(equalToConstant: lineSize)
//        ])
//        addHorizontal(firstBaselineHorizontal)
//    }
//
//    //    func addSuperiorTapView() {
//    //        let superiorView = [self createView:UIColor.clearColor];
//    //        window.superiorView = superiorView;
//    //        [NSLayoutConstraint activateConstraints:@[
//    //            [superiorView.topAnchor constraintEqualToAnchor: self.view.topAnchor],
//    //            [superiorView.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor],
//    //            [superiorView.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor],
//    //            [superiorView.heightAnchor constraintEqualToConstant: touchAreaHeight]
//    //        ]
//    //         ];
//    //    }
//
//    //    func addInferiorTapView() {
//    //        inferiorView = [self createView:UIColor.clearColor];
//    //        window.inferiorView = inferiorView;
//    //        [NSLayoutConstraint activateConstraints:@[
//    //            [inferiorView.bottomAnchor constraintEqualToAnchor: self.view.bottomAnchor],
//    //            [inferiorView.leadingAnchor constraintEqualToAnchor: self.view.leadingAnchor],
//    //            [inferiorView.trailingAnchor constraintEqualToAnchor: self.view.trailingAnchor],
//    //            [inferiorView.heightAnchor constraintEqualToConstant: touchAreaHeight]
//    //        ]
//    //         ];
//    //    }
//
//    //    - (void)handleTouchEvent {
//    //        switch (currentBaseline) {
//    //            case SPACING4:
//    //                currentBaseline = SPACING8;
//    //                [self setBaselineHidden:false];
//    //                [self setBaselineSpacing:8];
//    //                break;
//    //            case SPACING8:
//    //                currentBaseline = OFF;
//    //                [self setBaselineHidden:true];
//    //                break;
//    //            case OFF:
//    //                currentBaseline = SPACING4;
//    //                [self setBaselineHidden:false];
//    //                [self setBaselineSpacing:4];
//    //                break;
//    //        }
//    //    }
//
//    func setBaselineSpacing(_ value: CGFloat) {
//        verticalSpacing.forEach { $0.constant = value }
//        horizontalSpacing.forEach { $0.constant = value }
//    }
//
//    func setBaselineHidden(_ isHidden: Bool) {
//        verticalBaselines.forEach { $0.isHidden = isHidden }
//        horizontalBaselines.forEach { $0.isHidden = isHidden }
//    }
//
//    func addHorizontal(_ previuosBaseline: UIView) {
//        let horizontalColor = UIColor.purple.withAlphaComponent(0.3)
//        let baseline = createView(horizontalColor)
//        let spacing = baseline.topAnchor.constraint(equalTo: previuosBaseline.topAnchor)
//        horizontalBaselines.append(baseline)
//        horizontalSpacing.append(spacing)
//
//        NSLayoutConstraint.activate([
//            spacing,
//            baseline.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            baseline.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
//            baseline.heightAnchor.constraint(equalToConstant: lineSize)
//        ])
//        view.layoutSubviews()
//        if baseline.frame.maxY >= UIScreen.main.bounds.height {
//            return
//        } else {
//            addHorizontal(baseline)
//        }
//    }
//
//    func addVertical(_ previuosBaseline: UIView) {
//        let verticalColor = UIColor.green.withAlphaComponent(0.3)
//        let baseline = createView(verticalColor)
//        let spacing = baseline.leadingAnchor.constraint(equalTo: previuosBaseline.leadingAnchor, constant: lineSpacing)
//
//        verticalBaselines.append(baseline)
//        verticalSpacing.append(spacing)
//
//        NSLayoutConstraint.activate([
//            baseline.topAnchor.constraint(equalTo: view.topAnchor),
//            baseline.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            baseline.widthAnchor.constraint(equalToConstant: lineSize),
//            spacing
//        ])
//
//        view.layoutSubviews()
//        if baseline.frame.maxX >= UIScreen.main.bounds.width {
//            return
//        } else {
//            addVertical(baseline)
//        }
//    }
//
//    func createView(_ color: UIColor) -> UIView {
//        let baseline = UIView()
//        baseline.translatesAutoresizingMaskIntoConstraints = false
//        baseline.backgroundColor = color
//        baseline.isUserInteractionEnabled = false
//        self.view.addSubview(baseline)
//        self.view.sendSubviewToBack(baseline)
//        return baseline
//    }
//
//
//}
//
//class GridView: UIView {
//
//    let lineSize: CGFloat = 1;
//    let lineSpacing: CGFloat = 4;
//    let touchAreaHeight: CGFloat = 80;
//
//    func addBaselines() {
//        startBaselineVertical()
//        startBaselineHorizontal()
//        setBaselineHidden(true)
//    }
//
//
//    func createView(_ color: UIColor) -> UIView {
//        let baseline = UIView()
//        baseline.translatesAutoresizingMaskIntoConstraints = false
//        baseline.backgroundColor = color
//        baseline.isUserInteractionEnabled = false
//        self.addSubview(baseline)
//        self.sendSubviewToBack(baseline)
//        return baseline
//    }
//
//}
