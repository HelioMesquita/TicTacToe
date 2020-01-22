//
//  GridView.swift
//  TicTacToeExample
//
//  Created by Hélio Mesquita on 21/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import UIKit

class TicTacToeGridView: UIView {

    enum Baseline {
        case SPACING4
        case SPACING8
        case OFF
    }

    let lineSize: CGFloat = 1;
    let lineSpacing: CGFloat = 4;

    var currentBaseline: Baseline = .OFF

    var horizontalBaselines: [UIView] = []
    var horizontalSpacing: [NSLayoutConstraint] = []
    var verticalBaselines: [UIView] = []
    var verticalSpacing: [NSLayoutConstraint] = []

    init() {
        super.init(frame: UIScreen.main.bounds)
        translatesAutoresizingMaskIntoConstraints = false
        configureView()
        addBaselines()
        NotificationCenter.default.addObserver(self, selector: #selector(handleTouchEvent), name: .didChangeBaseline, object: nil)
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

    @objc func handleTouchEvent() {
        switch (currentBaseline) {
        case .SPACING4:
            currentBaseline = .SPACING8;
            setBaselineHidden(false)
            setBaselineSpacing(8)
            break;
        case .SPACING8:
            currentBaseline = .OFF;
            setBaselineHidden(true)
            break;
        case .OFF:
            currentBaseline = .SPACING4;
            setBaselineHidden(false)
            setBaselineSpacing(4)
            break;
        }
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
