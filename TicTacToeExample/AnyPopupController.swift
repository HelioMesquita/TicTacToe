//
//  JustPopup.swift
//  G5
//
//  Created by Mefodiy Akatov on 18.07.2019.
//  Copyright © 2019 Mefodiy Akatov. All rights reserved.
//

#if canImport(UIKit)

import SwiftUI
import Combine

public protocol AnyPopupController: class {

    var normalWindow: UIWindow { get set }
    var popupWindow: UIWindow? { get set }
    var popupController: UIViewController! { get set }

    // MARK: - Customization variables

    var animationDuration: TimeInterval { get set }
    var presentationDuration: TimeInterval? { get set }
    var dismissOnTap: Bool { get set }
    var fadesBackground: Bool { get set }

    
    // MARK: - Showing
    
    /// Just shows the popup and that's it
    func showPopup()

    
    /**
        Utility method that explicitly sets the background faded
     
        Theoretically might be used when writing custom popup,
        but I doubt if there is any sense in doing it
    */
    func setBackgroundFaded(_ faded: Bool)


    // MARK: - Hiding
    
    /// Just hides the popup and that's it
    func hidePopup()
    
    /**
        Use this method to make popup close after given publisher emits
       
        Note that it closes popup when the publisher emits any value
        and after that subscription automatically terminates.

        - parameter publisher:
            Some publisher with Any output type and Never failure type
    */
    func subscribeToClosingPublisher<T>(_ publisher: AnyPublisher<T, Never>) -> Self

    // MARK: - Customization

    func dismissOnTap(_ bool: Bool) -> Self
    func fadesBackground(_ bool: Bool) -> Self

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
        if fadesBackground  {
            setBackgroundFaded(true)
        }
        let popupView = popupController.view
        popupView?.alpha = 0
        
        
        UIView.animate(withDuration: animationDuration, animations: {
            popupView?.alpha = 1
            popupView?.transform = .identity
        }, completion: { _ in
            if let self_ = self as? UIViewController {
                self.popupController.didMove(toParent: self_)
            }
            NotificationCenter.default.post(name: .didViewAppearInPopup, object: true)
        })

        if let duration = presentationDuration {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: {
                self.hidePopup()
            })
        }
    }
    
    func hidePopup() {
        setBackgroundFaded(false)
        let popupView = popupController.view
        

            self.resignFromKeyWindow()
    }

    
    func dismissOnTap(_ bool: Bool = true) -> Self {
        dismissOnTap = bool
        return self
    }

    func fadesBackground(_ bool: Bool) -> Self {
        fadesBackground = bool
        return self
    }
    
    func subscribeToClosingPublisher<T>(_ publisher: AnyPublisher<T, Never>) -> Self {
        let subscriber = Subscribers.SinkFirstAndCancel<T> { [weak self] _ in
            self?.hidePopup()
        }
        publisher
            .receive(on: RunLoop.main)
            .subscribe(subscriber)
        return self
    }

}

public extension AnyPopupController where Self: UIViewController {
    
    func setBackgroundFaded(_ faded: Bool) {
        UIView.animate(withDuration: animationDuration + 0.1) {
            let color = faded ? UIColor.black.withAlphaComponent(0.75) : .clear
            self.view.backgroundColor = color
        }
    }

}

#endif
