//
//  ActionsView.swift
//  TicTacToeExample
//
//  Created by Hélio Mesquita on 21/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import UIKit

class TicTacToeActionsView: UIView {

    let touchAreaHeight: CGFloat = 80
    var superiorView: UIView?
    var inferiorView: UIView?

    init() {
        super.init(frame: UIScreen.main.bounds)
        translatesAutoresizingMaskIntoConstraints = false
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure() {
        addSuperiorTapView()
        addInferiorTapView()
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

    func addSuperiorTapView() {
        let superiorView = createView(UIColor.clear)
        self.superiorView = superiorView
        NSLayoutConstraint.activate([
            superiorView.topAnchor.constraint(equalTo: topAnchor),
            superiorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            superiorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            superiorView.heightAnchor.constraint(equalToConstant: touchAreaHeight)
        ])
    }

    func addInferiorTapView() {
        let inferiorView = createView(UIColor.clear)
        self.inferiorView = inferiorView
        NSLayoutConstraint.activate([
            inferiorView.bottomAnchor.constraint(equalTo: bottomAnchor),
            inferiorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            inferiorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            inferiorView.heightAnchor.constraint(equalToConstant: touchAreaHeight)
        ])
    }
}


