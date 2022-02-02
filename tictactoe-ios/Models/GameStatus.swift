//
//  GameStatus.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

import Foundation

class GameStatus {
    enum GameResult: String {
        case ongoing
        case win
        case draw
    }

    var result: GameResult
    var currentTurn: Player
    var winnerCombo: [IndexPath]?

    init() {
        result = .ongoing
        currentTurn = .circle
    }
}

extension GameStatus {
    func changeTurn() {
        guard result == .ongoing else { return }

        currentTurn = currentTurn == .circle ? .cross : .circle
    }

    func reset() {
        result = .ongoing
        currentTurn = .circle
        winnerCombo = nil
    }
}
