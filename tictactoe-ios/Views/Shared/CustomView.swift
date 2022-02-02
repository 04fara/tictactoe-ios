//
//  CustomView.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

import UIKit

class CustomView: RoundedView {
    override class var requiresConstraintBasedLayout: Bool {
        return true
    }

    init() {
        super.init(frame: .zero)

        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    internal func setupView() { }

    internal func setupLayout() { }
}
