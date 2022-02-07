//
//  AIDifficultyVC.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

import UIKit

class AIDifficultyVC: UIViewController {
    override func loadView() {
        let view = AIDifficultyView()
        view.easyButton.addTarget(self, action: #selector(startNewGame(_:)), for: .touchUpInside)
        view.mediumButton.addTarget(self, action: #selector(startNewGame(_:)), for: .touchUpInside)
        view.hardButton.addTarget(self, action: #selector(startNewGame(_:)), for: .touchUpInside)

        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "AI difficulty"
    }
}

extension AIDifficultyVC {
    @objc private func startNewGame(_ sender: UIButton) {
        // MARK: TODO add alert
        guard let navigationController = navigationController,
              let title = sender.titleLabel?.text,
              let mode = GameMode(rawValue: title),
              let difficulty = AIPlayerDifficulty(rawValue: title)
        else { return }

        navigationItem.title = "Main menu"

        let players = [Player(with: .circle), AIPlayer(with: .cross, difficulty: difficulty)]
        let game = Game(with: players)
        let gameVM = GameVM(with: game)
        let gameVC = GameVC(for: mode, with: gameVM)
        navigationController.pushViewController(gameVC, animated: true)
        navigationController.viewControllers.remove(at: 1)
    }
}
