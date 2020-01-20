//
//  JustPopupPreferences.swift
//  JustPopup
//
//  Created by Mefodiy Akatov on 24.07.2019.
//  Copyright © 2019 Eubicor. All rights reserved.
//

import Foundation

public class JustPopupPreferences {

    public var shouldFollowScenePattern: Bool = false
    
    public static let shared = JustPopupPreferences()
    
    private init() {}

}
