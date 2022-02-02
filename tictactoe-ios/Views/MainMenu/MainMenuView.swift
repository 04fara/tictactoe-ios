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

        return stackView
    }()

    let newGameButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.backgroundColor = .label
        button.setTitleColor(.systemBackground, for: .normal)
        button.setTitle("New Game", for: .normal)
        button.layer.cornerRadius = 10

        return button
    }()

    override internal func setupView() {
        containerView.addArrangedSubview(newGameButton)
        addSubview(containerView)
    }

    override internal func setupLayout() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 150),
            containerView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
