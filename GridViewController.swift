//
//  GridViewController.swift
//  GridView
//
//  Created by Helio Loredo Mesquita on 10/12/19.
//

import UIKit
import MediaPlayer

public class GridViewController: UIViewController {

    private enum Status {
        case on
        case baseline4
        case off

        func next() -> Status {
            switch self {
            case .on:
                return .baseline4
            case .baseline4:
                return .off
            case .off:
                return .on
            }
        }
    }

    public var isVolumeControllerHidden = true

    private let window = GridWindow()
    private var currentStatus: Status = .off
    private var horizontalBaselines: [UIView] = []
    private var horizontalSpacing: [NSLayoutConstraint] = []

    private var verticalBaselines: [UIView] = []
    private var verticalSpacing: [NSLayoutConstraint] = []

    @discardableResult
    public init() {
        super.init(nibName: nil, bundle: nil)
        window.windowLevel = UIWindow.Level(.greatestFiniteMagnitude)
//        window.windowLevel = UIWindow.Level(floatLiteral: .greatestFiniteMagnitude)
        window.isHidden = false
        window.rootViewController = self
        window.isUserInteractionEnabled = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("wrong implementation, prefer programmatically")
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        configureVolumeView()
        configureView()
        addBaselines()
    }

    private func addBaselines() {
        addHorizontal(previuosBaseline: nil)
        addVertical(previuosBaseline: nil)
//        verticalBaselines.forEach { $0.isHidden = true }
//        horizontalBaselines.forEach { $0.isHidden = true }
    }

    private func configureView() {
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = false
        window.view = view
    }

    private func configureVolumeView() {
        guard isVolumeControllerHidden else { return }
        let volumeView = MPVolumeView(frame: .zero)
        for subview in volumeView.subviews {
            guard let button = subview as? UIButton else { continue }
            button.setImage(nil, for: .normal)
            button.isEnabled = false
            button.sizeToFit()
        }
        UIApplication.shared.windows.first?.addSubview(volumeView)
        UIApplication.shared.windows.first?.sendSubviewToBack(volumeView)
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AVAudioSession.sharedInstance().addObserver(self, forKeyPath: "outputVolume", options: NSKeyValueObservingOptions.new, context: nil)
        do { try AVAudioSession.sharedInstance().setActive(true) }
        catch { debugPrint("\(error)") }
    }

    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        AVAudioSession.sharedInstance().removeObserver(self, forKeyPath: "outputVolume")
        do { try AVAudioSession.sharedInstance().setActive(false) }
        catch { debugPrint("\(error)") }
    }

    override public func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let key = keyPath else { return }
        switch key {
        case "outputVolume":
                let nextStatus = currentStatus.next()
                if nextStatus == .on {
                verticalBaselines.forEach { $0.isHidden = false }
                horizontalBaselines.forEach { $0.isHidden = false }
                verticalSpacing.forEach { $0.constant = 4 }
                horizontalSpacing.forEach { $0.constant = 4 }

                } else if nextStatus == .baseline4 {
                    verticalSpacing.forEach { $0.constant = 8 }
                    horizontalSpacing.forEach { $0.constant = 8 }

                } else {
                verticalBaselines.forEach { $0.isHidden = true }
                horizontalBaselines.forEach { $0.isHidden = true }
                }
                currentStatus = nextStatus

//            guard let dict = change, let temp = dict[NSKeyValueChangeKey.newKey] as? Float, temp != 0.5 else { return }
//            let systemSlider = MPVolumeView().subviews.first { (aView) -> Bool in
//                return NSStringFromClass(aView.classForCoder) == "MPVolumeSlider" ? true : false
//                } as? UISlider
//            systemSlider?.setValue(0.5, animated: false)
//            guard systemSlider != nil else { return }
//            debugPrint("Either volume button tapped.")
        default:
            break
        }
    }



    private func addHorizontal(lineSize: CGFloat = 1, lineSpacing: CGFloat = 4, previuosBaseline: UIView?) {
        if let previuosBaseline = previuosBaseline {
            let baseline = createBaselineAndAddView(.green)
            let spacing = baseline.topAnchor.constraint(equalTo: previuosBaseline.topAnchor, constant: lineSpacing)

            horizontalBaselines.append(baseline)
            horizontalSpacing.append(spacing)

            NSLayoutConstraint.activate([
                baseline.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                baseline.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                baseline.heightAnchor.constraint(equalToConstant: lineSize),
                spacing
            ])

            view.layoutSubviews()
            if baseline.frame.maxY >= UIScreen.main.bounds.height {
                return
            } else {
                addHorizontal(lineSize: lineSize, lineSpacing: lineSpacing, previuosBaseline: baseline)
            }

        } else {
            let baseline = createBaselineAndAddView(.green)
            horizontalBaselines.append(baseline)

            NSLayoutConstraint.activate([
                baseline.topAnchor.constraint(equalTo: view.topAnchor),
                baseline.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                baseline.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                baseline.heightAnchor.constraint(equalToConstant: lineSize)
            ])
            addHorizontal(lineSize: lineSize, lineSpacing: lineSpacing, previuosBaseline: baseline)
        }
    }

    private func addVertical(lineSize: CGFloat = 1, lineSpacing: CGFloat = 4, previuosBaseline: UIView?) {
        if let previuosBaseline = previuosBaseline {
            let baseline = createBaselineAndAddView(.purple)
            let spacing = baseline.leadingAnchor.constraint(equalTo: previuosBaseline.leadingAnchor, constant: lineSpacing)

            verticalBaselines.append(baseline)
            verticalSpacing.append(spacing)

            NSLayoutConstraint.activate([
                baseline.topAnchor.constraint(equalTo: view.topAnchor),
                baseline.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                baseline.widthAnchor.constraint(equalToConstant: lineSize),
                spacing
            ])

            view.layoutSubviews()
            if baseline.frame.maxX >= UIScreen.main.bounds.width {
                return
            } else {
                addVertical(lineSize: lineSize, lineSpacing: lineSpacing, previuosBaseline: baseline)
            }

        } else {
            let baseline = createBaselineAndAddView(.purple)
            verticalBaselines.append(baseline)

            NSLayoutConstraint.activate([
                baseline.topAnchor.constraint(equalTo: view.topAnchor),
                baseline.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                baseline.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                baseline.widthAnchor.constraint(equalToConstant: lineSize)
            ])
            addVertical(lineSize: lineSize, lineSpacing: lineSpacing, previuosBaseline: baseline)
        }
    }

    private func createBaselineAndAddView(_ color: UIColor) -> UIView {
        let baseline = createBaselineView(.purple)
        addAndSendToBack(baseline)
        return baseline
    }

    private func createBaselineView(_ color: UIColor) -> UIView {
        let baseline = UIView()
        baseline.translatesAutoresizingMaskIntoConstraints = false
        baseline.backgroundColor = color
        baseline.isUserInteractionEnabled = false
        return baseline
    }

    private func addAndSendToBack(_ baseline: UIView) {
        view.addSubview(baseline)
        view.sendSubviewToBack(baseline)
    }

    deinit {
        print("dealocado")
    }
}
