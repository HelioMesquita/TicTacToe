//
//  PopupViewController.swift
//  JustPopup
//
//  Created by Mefodiy Akatov on 23.07.2019.
//  Copyright © 2019 Eubicor. All rights reserved.
//

import UIKit

public class Popup: UIViewController {

    public var normalWindow: UIWindow
    public var popupWindow: UIWindow?
    public var popupController: UIViewController!

    public init() {
        self.normalWindow = UIApplication.topWindow()
        super.init(nibName: nil, bundle: nil)
        popupController = GridViewController()
        setupPopupController()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }

    private func setupPopupController() {
        addChild(popupController)
        popupController.view.frame = UIScreen.main.bounds
        view.addSubview(popupController.view)
    }

    func makeSelfKeyWindow() {
        popupWindow = rightWindow()
        popupWindow?.frame = UIScreen.main.bounds
        popupWindow?.backgroundColor = .clear
        popupWindow?.windowLevel = UIWindow.Level.statusBar + 1
        popupWindow?.rootViewController = self
        popupWindow?.makeKeyAndVisible()
    }

    func rightWindow() -> UIWindow {
        if JustPopupPreferences.shared.shouldFollowScenePattern {
            let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive })
            if let windowScene = windowScene as? UIWindowScene {
                return NewWindow(windowScene: windowScene)
            }
        }
        return NewWindow()
    }

    func showPopup() {
        makeSelfKeyWindow()
        popupController?.didMove(toParent: self)
    }


}

private class GridViewController: UIViewController {

    var gridView: UIView

    public init() {
        self.gridView = GridView()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {
        super.loadView()
        view = gridView
    }

}

class GridView: UIView {

    let lineSize: CGFloat = 1;
    let lineSpacing: CGFloat = 4;
    let touchAreaHeight: CGFloat = 80;

    var horizontalBaselines: [UIView] = []
    var horizontalSpacing: [NSLayoutConstraint] = []
    var verticalBaselines: [UIView] = []
    var verticalSpacing: [NSLayoutConstraint] = []

    init() {
        super.init(frame: UIScreen.main.bounds)
        configureView()
        addBaselines()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureView() {
        backgroundColor = UIColor.clear
        isUserInteractionEnabled = false
    }

    func addBaselines() {
        startBaselineVertical()
        startBaselineHorizontal()
//        setBaselineHidden(true)
    }

    func startBaselineVertical() {
        let verticalColor = UIColor.green.withAlphaComponent(0.3)
        let numberOfDivisions: Int = Int(UIScreen.main.bounds.width/4)

        let firstBaselineVertical = createView(verticalColor)
        verticalBaselines.append(firstBaselineVertical)
        NSLayoutConstraint.activate([
            firstBaselineVertical.topAnchor.constraint(equalTo: self.topAnchor),
            firstBaselineVertical.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            firstBaselineVertical.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            firstBaselineVertical.widthAnchor.constraint(equalToConstant: lineSize)
        ])

        for _ in 1...numberOfDivisions {
            guard let previuosBaseline = verticalBaselines.last else { continue }
            let baseline = createView(verticalColor)
            let spacing = baseline.leadingAnchor.constraint(equalTo: previuosBaseline.leadingAnchor, constant: lineSpacing)
            verticalBaselines.append(baseline)
            verticalSpacing.append(spacing)

            NSLayoutConstraint.activate([
                baseline.topAnchor.constraint(equalTo: topAnchor),
                baseline.bottomAnchor.constraint(equalTo: bottomAnchor),
                baseline.widthAnchor.constraint(equalToConstant: lineSize),
                spacing
            ])
        }
    }

    func startBaselineHorizontal() {
        let horizontalColor = UIColor.purple.withAlphaComponent(0.3)
        let numberOfDivisions: Int = Int(UIScreen.main.bounds.height/4)

        let firstBaselineHorizontal = createView(horizontalColor)
        horizontalBaselines.append(firstBaselineHorizontal)
        NSLayoutConstraint.activate([
            firstBaselineHorizontal.topAnchor.constraint(equalTo: self.topAnchor),
            firstBaselineHorizontal.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            firstBaselineHorizontal.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            firstBaselineHorizontal.heightAnchor.constraint(equalToConstant: lineSize)
        ])

        for _ in 1...numberOfDivisions {
            guard let previuosBaseline = horizontalBaselines.last else { continue }
            let baseline = createView(horizontalColor)
            let spacing = baseline.topAnchor.constraint(equalTo: previuosBaseline.topAnchor, constant: lineSpacing)
            horizontalBaselines.append(baseline)
            horizontalSpacing.append(spacing)

            NSLayoutConstraint.activate([
                spacing,
                baseline.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                baseline.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                baseline.heightAnchor.constraint(equalToConstant: lineSize)
            ])
        }

    }

    func setBaselineSpacing(_ value: CGFloat) {
        verticalSpacing.forEach { $0.constant = value }
        horizontalSpacing.forEach { $0.constant = value }
    }

    func setBaselineHidden(_ isHidden: Bool) {
        verticalBaselines.forEach { $0.isHidden = isHidden }
        horizontalBaselines.forEach { $0.isHidden = isHidden }
    }

    func createView(_ color: UIColor) -> UIView {
        let baseline = UIView()
        baseline.translatesAutoresizingMaskIntoConstraints = false
        baseline.backgroundColor = color
        baseline.isUserInteractionEnabled = false
        self.addSubview(baseline)
        self.sendSubviewToBack(baseline)
        return baseline
    }

}
