//
//  GridWindow.swift
//  GridView
//
//  Created by Helio Loredo Mesquita on 10/12/19.
//

import UIKit

class GridWindow: UIWindow {

    var view: UIView?

    init() {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = nil
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard let view = view else { return false }
        let viewPoint = convert(point, to: view)
        return view.point(inside: viewPoint, with: event)
    }

}
