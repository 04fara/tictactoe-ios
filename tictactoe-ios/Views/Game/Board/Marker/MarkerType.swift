//
//  MarkerType.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

import UIKit

enum MarkerType {
    case circle
    case cross
    case none
}

extension MarkerType {
    func path(in rect: CGRect) -> UIBezierPath? {
        let path = UIBezierPath()
        switch self {
        case .circle:
            let center = CGPoint(x: rect.width / 2, y: rect.height / 2),
                radius = min(rect.width, rect.height) / 2
            path.addArc(withCenter: center, radius: radius, startAngle: -.pi * 0.50, endAngle: .pi * 0.50, clockwise: false)
            path.addArc(withCenter: center, radius: radius, startAngle: .pi * 0.50, endAngle: -.pi * 0.50, clockwise: false)
        case .cross:
            path.move(to: .init(x: rect.width, y: 0))
            path.addLine(to: .init(x: 0, y: rect.height))
            path.move(to: .zero)
            path.addLine(to: .init(x: rect.width, y: rect.height))
        case .none:
            return nil
        }

        return path
    }
}
