//
//  BoardView.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

import UIKit

class BoardView: UICollectionView {
    init() {
        let layout = UICollectionViewFlowLayout()
        super.init(frame: .zero, collectionViewLayout: layout)

        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BoardView {
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .label
        bounces = false

        allowsMultipleSelection = true
        register(BoardCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: BoardCollectionViewCell.self))
    }

    private func setupLayout() {

    }
}
