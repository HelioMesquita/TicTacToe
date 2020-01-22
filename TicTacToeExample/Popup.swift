//
//  PopupViewController.swift
//  JustPopup
//
//  Created by Mefodiy Akatov on 23.07.2019.
//  Copyright © 2019 Eubicor. All rights reserved.
//

import UIKit

public class Popup: UIViewController {

    var normalWindow: UIWindow
    var popupWindow: NewWindow?
    var gridController: GridViewController!

    public init() {
        self.normalWindow = UIApplication.topWindow()
        super.init(nibName: nil, bundle: nil)
        gridController = GridViewController()
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
        addChild(gridController)
        gridController.view.frame = UIScreen.main.bounds
        view.addSubview(gridController.view)
    }

    func makeSelfKeyWindow() {
        popupWindow = rightWindow()
        popupWindow?.frame = UIScreen.main.bounds
        popupWindow?.backgroundColor = .clear
        popupWindow?.windowLevel = UIWindow.Level.statusBar + 1
        popupWindow?.rootViewController = self
        popupWindow?.makeKeyAndVisible()
        popupWindow?.inferiorView = gridController.actionsView.inferiorView
        popupWindow?.superiorView = gridController.actionsView.superiorView
    }

    func rightWindow() -> NewWindow {
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
        gridController?.didMove(toParent: self)
    }

}
