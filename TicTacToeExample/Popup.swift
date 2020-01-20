//
//  PopupViewController.swift
//  JustPopup
//
//  Created by Mefodiy Akatov on 23.07.2019.
//  Copyright © 2019 Eubicor. All rights reserved.
//

import UIKit

public class Popup: UIViewController, AnyPopupController {

    public var normalWindow: UIWindow
    public var popupWindow: UIWindow?
    public var popupController: UIViewController!

    public init(_ view: UIView, fromWindow: UIWindow? = nil) {
        self.normalWindow = fromWindow ?? UIApplication.topWindow()
        super.init(nibName: nil, bundle: nil)
        popupController = PopupViewController(popupView: view)
        setupPopupController()
    }

    public init(_ popupController: UIViewController, fromWindow: UIWindow? = nil) {
        self.normalWindow = fromWindow ?? UIApplication.topWindow()
        self.popupController = popupController
        super.init(nibName: nil, bundle: nil)
        setupPopupController()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = .clear
    }

    private func setupPopupController() {
        addChild(popupController)
        popupController.view.frame = UIScreen.main.bounds
        view.addSubview(popupController.view)
    }

}

private class PopupViewController: UIViewController {

    var popupView: UIView

    public init(popupView: UIView) {
        self.popupView = popupView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func loadView() {
        super.loadView()
        view = popupView
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
            let baseline = createView(verticalColor)
            guard let previuosBaseline = verticalBaselines.last else { continue }
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
            let baseline = createView(horizontalColor)
            guard let previuosBaseline = horizontalBaselines.last else { continue }
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
