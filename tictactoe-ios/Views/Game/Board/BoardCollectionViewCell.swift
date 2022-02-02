//
//  BoardCollectionViewCell.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

import UIKit

class BoardCollectionViewCell: UICollectionViewCell {
    let markerView: MarkerView = {
        let markerView = MarkerView()
        markerView.translatesAutoresizingMaskIntoConstraints = false

        return markerView
    }()

    override class var requiresConstraintBasedLayout: Bool {
        return true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BoardCollectionViewCell {
    private func setupView() {
        backgroundColor = .systemBackground
        contentView.backgroundColor = .systemBackground

        contentView.addSubview(markerView)
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            markerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            markerView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            markerView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.65),
            markerView.heightAnchor.constraint(equalTo: markerView.widthAnchor)
        ])
    }

    func configure() {

    }
}
