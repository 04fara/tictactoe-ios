//
//  PlayerInteractor.swift
//  tictactoe-ios
//
//  Created by F K on 14/02/2022.
//

import Foundation

class PlayerInteractor: BaseInteractor {
    unowned var gameInteractor: GameInteractor
    let player: Player

    init(with player: Player, gameInteractor: GameInteractor) {
        self.player = player
        self.gameInteractor = gameInteractor
    }

    func makeMove(at position: Int?) -> Result<GameResult, TicTacToeError> {
        return .failure(.unknown)
    }
}
