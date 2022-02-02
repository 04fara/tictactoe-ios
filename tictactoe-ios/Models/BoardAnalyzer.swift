//
//  BoardAnalyzer.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

import Foundation

class BoardAnalyzer {
    private var scores: [Int]
    private var lastMove: Move?

    init() {
        scores = .init(repeating: 0, count: 8)
    }
}

extension BoardAnalyzer {
    func hasWinner() -> [IndexPath]? {
        guard let lastMove = lastMove else {
            return nil
        }

        let winCondition = lastMove.player == .circle ? 3 : -3,
            winCombinationIdx = scores.enumerated().filter { _, val in
                val == winCondition
            }.first?.offset

        guard let winCombinationIdx = winCombinationIdx else { return nil }

        var winCombination: [IndexPath]?
        switch winCombinationIdx {
        case 0, 1, 2:
            winCombination = [
                [winCombinationIdx, 0],
                [winCombinationIdx, 1],
                [winCombinationIdx, 2]
            ]
        case 3, 4, 5:
            winCombination = [
                [0, winCombinationIdx - 3],
                [1, winCombinationIdx - 3],
                [2, winCombinationIdx - 3]
            ]
        case 6:
            winCombination = [
                [0, 0],
                [1, 1],
                [2, 2]
            ]
        case 7:
            winCombination = [
                [0, 2],
                [1, 1],
                [2, 0]
            ]
        default:
            break
        }

        return winCombination
    }

    func updateScores(after move: Move) {
        let x = move.x
        let y = move.y
        let val = move.player == .circle ? 1 : -1

        scores[x] += val
        scores[y + 3] += val
        scores[6] += val * (x == y ? 1 : 0)
        scores[7] += val * (x + y == 2 ? 1 : 0)
        lastMove = move
    }

    func reset() {
        scores = .init(repeating: 0, count: 8)
        lastMove = nil
    }
}
