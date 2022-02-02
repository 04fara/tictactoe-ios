//
//  MainMenuVC.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

import UIKit

class MainMenuVC: UIViewController {
    override func loadView() {
        let view = MainMenuView()
        view.newGameButton.addTarget(self, action: #selector(startNewGame), for: .touchUpInside)

        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Main menu"
    }
}

extension MainMenuVC {
    @objc private func startNewGame() {
        let gameVC = GameVC()
        navigationController?.pushViewController(gameVC, animated: true)
    }
}
