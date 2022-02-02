//
//  MarkerView.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

import UIKit

class MarkerView: UIView {
    var type: Marker = .none {
        didSet {
            guard oldValue != type else { return }

            switch type {
            case .none:
                erase(animated: true)
            case .circle, .cross:
                draw(animated: true)
            }
        }
    }

    private let animation: CABasicAnimation = {
        let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))
        animation.timingFunction = .init(name: .easeInEaseOut)
        animation.duration = 0.5
        animation.fillMode = .forwards

        return animation
    }()

    private var sublayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.lineWidth = 10

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

        if animated {
            animation.fromValue = 0
            animation.toValue = 1
            sublayer.add(animation, forKey: "DrawMarker")
        }
        sublayer.path = path.cgPath
    }

    func erase(animated: Bool = false) {
        if animated {
            CATransaction.begin()
            CATransaction.setCompletionBlock { [weak self] in
                self?.sublayer.path = nil
                self?.superview?.isUserInteractionEnabled = true
            }
            superview?.isUserInteractionEnabled = false
            animation.fromValue = 1
            animation.toValue = 0
            sublayer.add(animation, forKey: "EraseMarker")
            CATransaction.commit()
        }
        type = .none
    }
}
