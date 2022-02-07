//
//  AIDifficultyView.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

import UIKit

class AIDifficultyView: CustomView {
    let containerView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16

        return stackView
    }()

    lazy var easyButton: UIButton = getDifficultyButton(for: "Easy")
    lazy var mediumButton: UIButton = getDifficultyButton(for: "Medium")
    lazy var hardButton: UIButton = getDifficultyButton(for: "Hard")

    override internal func setupView() {
        containerView.addArrangedSubview(easyButton)
        containerView.addArrangedSubview(mediumButton)
        containerView.addArrangedSubview(hardButton)
        addSubview(containerView)
    }

    override internal func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 150),
            containerView.heightAnchor.constraint(equalToConstant: 170)
        ])
    }
}

extension AIDifficultyView {
    private func getDifficultyButton(for title: String) -> UIButton {
        let button = UIButton(type: .roundedRect)
        button.backgroundColor = .label
        button.setTitleColor(.systemBackground, for: .normal)
        button.setTitle(title, for: .normal)
        button.layer.cornerRadius = 10

        return button
    }
}
