//
//  JustPopupPreferences.swift
//  JustPopup
//
//  Created by Mefodiy Akatov on 24.07.2019.
//  Copyright © 2019 Eubicor. All rights reserved.
//

import Foundation

public class TicTacToePreferences {

    var isUsingScenePattern: Bool = false
    let container: TicTacToeContainer
    
    public static let shared = TicTacToePreferences()
    
    private init() {
        self.container = TicTacToeContainer()
    }

    func show() {
        container.show()
    }

    func remove() {
        container.remove()
    }

}
