//
//  MarkerView.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

import UIKit

class MarkerView: UIView {
    var type: MarkerType = .none {
        didSet {
            guard oldValue != type else { return }

            switch type {
            case .circle, .cross:
                draw(animated: true)
            case .none:
                erase(animated: true)
            }
        }
    }

    private var drawAnimation: CABasicAnimation {
        let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        animation.duration = 0.5
        animation.timingFunction = .init(name: .easeInEaseOut)
        animation.fromValue = sublayer.strokeEnd

        return animation
    }

    private var eraseAnimation: CABasicAnimation {
        let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.lineWidth))
        animation.duration = 0.25
        animation.timingFunction = .init(name: .easeIn)
        animation.fromValue = sublayer.lineWidth

        return animation
    }

    private var sublayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 10
        layer.strokeEnd = 0

        return layer
    }()

    var markerColor: MarkerColor = .normal {
        didSet {
            let color: UIColor
            switch markerColor {
            case .normal:
                color = .label
            case .winner:
                color = .systemGreen
            case .disabled:
                color = .systemGray
            }
            sublayer.strokeColor = color.resolvedColor(with: traitCollection).cgColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        layer.addSublayer(sublayer)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func draw(animated: Bool = false) {
        guard let path = type.path(in: frame) else { return }

        sublayer.path = path.cgPath
        if animated {
            let animation = drawAnimation
            sublayer.strokeEnd = 1
            sublayer.add(animation, forKey: "MarkerStrokeEnd")
        }
    }

    func erase(animated: Bool = false) {
        if animated {
            CATransaction.begin()
            CATransaction.setCompletionBlock { [weak self] in
                self?.sublayer.path = nil
                self?.sublayer.lineWidth = 10
                self?.sublayer.strokeEnd = 0
                self?.superview?.isUserInteractionEnabled = true
            }
            superview?.isUserInteractionEnabled = false
            let animation = eraseAnimation
            sublayer.lineWidth = 0
            sublayer.add(animation, forKey: "MarkerLineWidth")
            CATransaction.commit()
        }
    }
}
