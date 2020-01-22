//
//  Extensions.swift
//  JustPopup
//
//  Created by Mefodiy Akatov on 21.07.2019.
//  Copyright © 2019 Eubicor. All rights reserved.
//
import UIKit

extension UIApplication {
    
    static func topWindow() -> UIWindow {
        guard let window = UIApplication.shared.windows.last else {
            fatalError("No top windows for use in JustPopup. Specify concrete window in initializer")
        }
        return window
    }

}

public extension Notification.Name {
    static let didChangeBaseline = Notification.Name("didChangeBaseline")
}
