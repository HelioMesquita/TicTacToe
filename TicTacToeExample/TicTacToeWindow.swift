//
//  NewWindow.swift
//  TicTacToeExample
//
//  Created by Hélio Mesquita on 20/01/20.
//  Copyright © 2020 Hélio Mesquita. All rights reserved.
//

import UIKit

class TicTacToeWindow: UIWindow {

    var timer: Timer?
    var taps: [UIView] = []
    var superiorView: UIView?
    var inferiorView: UIView?

    override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
        frame = UIScreen.main.bounds
    }

    init() {
        super.init(frame: UIScreen.main.bounds)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timerFired), userInfo: nil, repeats: false)
        }

        let p = convert(point, to: self)
        
        if inferiorView!.frame.contains(p) {
            print("click inferior")
            taps.append(inferiorView!)
        }

        if superiorView!.frame.contains(p) {
            print("click superior")
            taps.append(superiorView!)
        }


        return nil
    }

    @objc func timerFired() {
        if taps.count == 2 {
            print("top")
            NotificationCenter.default.post(name: .didChangeBaseline, object: true)
        }
        taps.removeAll()
        timer?.invalidate()
        timer = nil;
    }
}
