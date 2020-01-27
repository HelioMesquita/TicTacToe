//
//  ViewController.swift
//  TicTacToeExample
//
//  Created by Hélio Mesquita on 25/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        button.addTarget(self, action: #selector(showPopup), for: .touchUpInside)
        button.setTitle("Show popup", for: .normal)
        button.backgroundColor = .systemFill
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

    @objc func showPopup() {
        
    }


}

