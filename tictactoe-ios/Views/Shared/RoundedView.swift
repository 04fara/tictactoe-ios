//
//  RoundedView.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

import UIKit

class RoundedView: UIView {
    override func draw(_ rect: CGRect) {
        let ctx = UIGraphicsGetCurrentContext(),
            roundedRectPath = UIBezierPath(roundedRect: rect, cornerRadius: layer.cornerRadius)
        ctx?.addPath(roundedRectPath.cgPath)
        roundedRectPath.addClip()
        backgroundColor?.setFill()
        roundedRectPath.fill()
        ctx?.fillPath()
    }
}
