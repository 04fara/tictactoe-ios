//
//  AIPlayerInteractor.swift
//  tictactoe-ios
//
//  Created by F K on 14/02/2022.
//

import Foundation

class AIPlayerInteractor: PlayerInteractor {
    override func makeMove(at position: Int? = nil) -> Result<GameResult, TicTacToeError> {
        guard let player = player as? AIPlayer else { return .failure(.unknown) }

        if let position = position {
            return gameInteractor.attemptMove(at: position)
        }

        let position: Int?
        switch player.difficulty {
        case .easy:
            position = randomMove()
        case .medium:
            let decision = Int.random(in: 0..<2)
            switch decision {
            case 0:
                position = randomMove()
            case 1:
                position = bestMove()
            default:
                return .failure(.unknown)
            }
        case .hard:
            position = bestMove()
        }

        guard let position = position else { return .failure(.unknown) }

        gameInteractor.isAITurn = false
        return gameInteractor.attemptMove(at: position)
    }
}

extension AIPlayerInteractor {
    private func randomMove() -> Int? {
        var available: [Int] = []
        for i in 0..<9 {
            let cell = gameInteractor.board.getCell(at: i)
            if cell == .empty {
                available.append(i)
            }
        }

        return available.randomElement()
    }

    private func bestMove() -> Int {
        var bestScore = Int.min
        var position: Int = -1
        for i in 0..<9 {
            gameInteractor.isAITurn = false
            let moveResult = gameInteractor.attemptMove(at: i)
            switch moveResult {
            case .success(let result):
                switch result {
                case.ongoing:
                    let score = minimax(0, false, .min, .max)
                    if score > bestScore {
                        bestScore = score
                        position = i
                    }
                    gameInteractor.undoLastMove()
                default:
                    gameInteractor.undoLastMove()

                    return i
                }
            case .failure:
                //print("AI at \(i): \(error)")
                break
            }
        }

        return position
    }

    private func minimax(_ depth: Int, _ isMaximizing: Bool, _ alpha: Int, _ beta: Int) -> Int {
        var alpha = alpha
        var beta = beta
        var bestScore: Int = isMaximizing ? .min : .max
        for i in 0..<9 {
            gameInteractor.isAITurn = false
            let moveResult = gameInteractor.turn.makeMove(at: i)
            switch moveResult {
            case .success(let result):
                switch result {
                case.ongoing:
                    let score = minimax(depth + 1, !isMaximizing, .min, .max)
                    bestScore = isMaximizing ? max(score, bestScore) : min(score, bestScore)
                    if isMaximizing {
                        alpha = max(score, alpha)
                    } else {
                        beta = min(score, beta)
                    }
                    if alpha >= beta {
                        return bestScore
                    }
                    gameInteractor.undoLastMove()
                case .draw:
                    gameInteractor.undoLastMove()

                    return 0
                case .win(let player, _):
                    gameInteractor.undoLastMove()

                    return player is AIPlayer ? 10 - depth : -10 + depth
                }
            case .failure:
                //print("AI at \(i) depth \(depth): \(error)")
                break
            }
        }

        return bestScore
    }
}
