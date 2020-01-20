//
//  JustPopup.swift
//  G5
//
//  Created by Mefodiy Akatov on 18.07.2019.
//  Copyright © 2019 Mefodiy Akatov. All rights reserved.
//

#if canImport(UIKit)

import UIKit

public protocol AnyPopupController: class {

    var normalWindow: UIWindow { get set }
    var popupWindow: UIWindow? { get set }
    var popupController: UIViewController! { get set }


    func showPopup()
    func hidePopup()


}

public extension AnyPopupController {

    func makeSelfKeyWindow() {
        popupWindow = rightWindow()
        popupWindow?.frame = UIScreen.main.bounds
        popupWindow?.backgroundColor = .clear
        popupWindow?.windowLevel = UIWindow.Level.statusBar + 1
        popupWindow?.rootViewController = self as? UIViewController
        popupWindow?.makeKeyAndVisible()
    }
    
    func rightWindow() -> UIWindow {
        if JustPopupPreferences.shared.shouldFollowScenePattern {
            let windowScene = UIApplication.shared
                .connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .first
            if let windowScene = windowScene as? UIWindowScene {
                return UIWindow(windowScene: windowScene)
            }
        }
        return UIWindow()
    }

    func resignFromKeyWindow() {
        popupWindow?.rootViewController = nil
        popupWindow = nil
        normalWindow.makeKeyAndVisible()
    }

    func showPopup() {
        makeSelfKeyWindow()

            if let self_ = self as? UIViewController {
                self.popupController.didMove(toParent: self_)
            }
    }
    
    func hidePopup() {
        let popupView = popupController.view
        

            self.resignFromKeyWindow()
    }

}

#endif
