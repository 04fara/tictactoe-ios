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
        view.newGameLocalButton.addTarget(self, action: #selector(startNewGame(_:)), for: .touchUpInside)
        view.newGameAIButton.addTarget(self, action: #selector(startNewGame(_:)), for: .touchUpInside)

        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Main menu"
    }
}

extension MainMenuVC {
    @objc private func startNewGame(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }

        let vc: UIViewController
        switch title {
        case "New game (Local)":
            vc = GameVC(for: .local)
        case "New game (AI)":
            vc = AIDifficultyVC()
        default:
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}
