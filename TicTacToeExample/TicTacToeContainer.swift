//
//  PopupViewController.swift
//  JustPopup
//
//  Created by Mefodiy Akatov on 23.07.2019.
//  Copyright © 2019 Eubicor. All rights reserved.
//

import UIKit

public class TicTacToeContainer: UIViewController {

    var normalWindow: UIWindow
    var popupWindow: TicTacToeWindow?
    var childViewController: TicTacToeViewController

    public init() {
        self.normalWindow = UIApplication.topWindow()
        childViewController = TicTacToeViewController()
        super.init(nibName: nil, bundle: nil)
        setupViewController()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
    }

    private func setupViewController() {
        addChild(childViewController)
        childViewController.view.frame = UIScreen.main.bounds
        view.addSubview(childViewController.view)
    }

    func makeSelfKeyWindow() {
        popupWindow = getWindow()
        popupWindow?.frame = UIScreen.main.bounds
        popupWindow?.backgroundColor = .clear
        popupWindow?.windowLevel = UIWindow.Level.statusBar + 1
        popupWindow?.rootViewController = self
        popupWindow?.makeKeyAndVisible()
        popupWindow?.inferiorView = childViewController.actionsView.inferiorView
        popupWindow?.superiorView = childViewController.actionsView.superiorView
    }

    func getWindow() -> TicTacToeWindow {
        if TicTacToePreferences.shared.isUsingScenePattern {
            let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive })
            if let windowScene = windowScene as? UIWindowScene {
                return TicTacToeWindow(windowScene: windowScene)
            }
        }
        return TicTacToeWindow()
    }

    func show() {
        if popupWindow == nil {
            makeSelfKeyWindow()
            childViewController.didMove(toParent: self)
        }
    }

    func remove() {
        popupWindow?.rootViewController = nil
        popupWindow = nil
        normalWindow.makeKeyAndVisible()
    }

}
