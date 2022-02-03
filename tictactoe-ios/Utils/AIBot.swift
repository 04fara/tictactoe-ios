//
//  AIBot.swift
//  tictactoe-ios
//
//  Created by F K on 02/02/2022.
//

import Foundation

class AIBot: Bot {
    private var difficulty: String
    private var attemptedMoves: Set<IndexPath> = .init()

    init(withDifficulty difficulty: String) {
        self.difficulty = difficulty
    }

    func makeMove() -> IndexPath {
        var move: IndexPath
        repeat {
            move = [.random(in: 0..<3), .random(in: 0..<3)]
        } while attemptedMoves.contains(move)

        return move
    }

    func reset() {
        attemptedMoves = .init()
    }
}
