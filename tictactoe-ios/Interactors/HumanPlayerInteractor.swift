//
//  PlayerInteractor.swift
//  tictactoe-ios
//
//  Created by F K on 14/02/2022.
//

import Foundation

class HumanPlayerInteractor: PlayerInteractor {
    override func makeMove(at position: Int?) -> Result<GameResult, TicTacToeError> {
        guard let position = position else {
            return .failure(.unknown)
        }

        return gameInteractor.attemptMove(at: position)
    }
}
