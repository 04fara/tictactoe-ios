//
//  GameVC.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

import UIKit

class GameVC: UIViewController {
    private let boardVC: BoardVC = {
        let boardVC = BoardVC()
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false

        return boardVC
    }()

    private var boardView: BoardView {
        return boardVC.view as! BoardView
    }

    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        view.addSubview(boardVC.view)
    }

    override func viewWillLayoutSubviews() {
        NSLayoutConstraint.activate([
            boardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            boardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            boardView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -60),
            boardView.heightAnchor.constraint(equalTo: boardView.widthAnchor)
        ])
    }
}
