//
//  Game.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

import Foundation

class Game {
    let board: Board
    private(set) var status: GameStatus

    init() {
        board = .init()
        status = .init()
    }
}

extension Game {
    func makeMove(at position: IndexPath) -> Result<[IndexPath]?, TicTacToeError> {
        guard status.result == .ongoing else { return .failure(.gameFinished) }

        let move = Move(at: position, with: status.currentTurn)
        switch board.makeMove(move) {
        case .success(let winnerCombo):
            switch true {
            case winnerCombo != nil:
                status.result = .win
                status.winnerCombo = winnerCombo
            case board.hasAvailableCells():
                status.changeTurn()
            default:
                status.result = .draw
                status.winnerCombo = []
            }

            return .success(status.winnerCombo)
        case .failure(let error):
            return .failure(error)
        }
    }

    func reset() {
        board.reset()
        status.reset()
    }
}
