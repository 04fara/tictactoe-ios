//
//  MainMenuView.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

import UIKit

class MainMenuView: CustomView {
    let containerView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16

        return stackView
    }()

    lazy var newGameLocalButton: UIButton = getNewGameButton(for: "Local")
    lazy var newGameAIButton: UIButton = getNewGameButton(for: "AI")

    override internal func setupView() {
        containerView.addArrangedSubview(newGameLocalButton)
        containerView.addArrangedSubview(newGameAIButton)
        addSubview(containerView)
    }

    override internal func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 150),
            containerView.heightAnchor.constraint(equalToConstant: 110)
        ])
    }
}

extension MainMenuView {
    private func getNewGameButton(for title: String) -> UIButton {
        let button = UIButton(type: .roundedRect)
        button.backgroundColor = .label
        button.setTitleColor(.systemBackground, for: .normal)
        button.setTitle("New game (\(title))", for: .normal)
        button.layer.cornerRadius = 10

        return button
    }
}
