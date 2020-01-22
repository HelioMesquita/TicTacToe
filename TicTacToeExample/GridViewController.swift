//
//  GridViewController.swift
//  TicTacToeExample
//
//  Created by Hélio Mesquita on 21/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import UIKit

class GridViewController: UIViewController {

    var gridView: GridView
    var actionsView: ActionsView

    public init() {
        self.gridView = GridView()
        self.actionsView = ActionsView()
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(gridView)
        self.view.addSubview(actionsView)
        NSLayoutConstraint.activate([
            gridView.topAnchor.constraint(equalTo: self.view.topAnchor),
            gridView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            gridView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            gridView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),

            actionsView.topAnchor.constraint(equalTo: self.view.topAnchor),
            actionsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            actionsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            actionsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }

}
