//
//  AIBot.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

class AIBot: Bot {
    static func makeMove(on board: Board, with difficulty: AIPlayerDifficulty) -> Int? {
        switch difficulty {
        case .easy:
            return randomMove(on: board)
        case .medium:
            let decision = Int.random(in: 0..<2)
            switch decision {
            case 0:
                return randomMove(on: board)
            case 1:
                return bestMove(on: board)
            default:
                break
            }
        case .hard:
            return bestMove(on: board)
        }

        return nil
    }
}

extension AIBot {
    private static func randomMove(on board: Board) -> Int? {
        var available: [Int] = []
        for i in 0..<9 {
            let cell = board.getCell(at: i)
            if cell == .empty {
                available.append(i)
            }
        }

        return available.randomElement()
    }

    private static func bestMove(on board: Board) -> Int? {
        var bestScore = Int.min
        var position: Int?
        for i in 0..<9 {
            let cell = board.getCell(at: i)
            if cell == .empty {
                var board = board
                let move = board.makeMove(at: i)
                switch move {
                case .success(let result):
                    switch result {
                    case .ongoing:
                        let score = minimax(board, 0, false, .min, .max)
                        if score > bestScore {
                            bestScore = score
                            position = i
                        }
                    default:
                        return i
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }

        return position
    }

    private static func minimax(_ board: Board, _ depth: Int, _ isMaximizing: Bool, _ alpha: Int, _ beta: Int) -> Int {
        var alpha = alpha
        var beta = beta
        var bestScore: Int = isMaximizing ? .min : .max
        for i in 0..<9 {
            var board = board
            let cell = board.getCell(at: i)
            if cell == .empty {
                let move = board.makeMove(at: i)
                switch move {
                case .success(let result):
                    switch result {
                    case .ongoing:
                        let score = minimax(board, depth + 1, !isMaximizing, alpha, beta)
                        bestScore = isMaximizing ? max(score, bestScore) : min(score, bestScore)

                        if isMaximizing {
                            alpha = max(alpha, score)
                        } else {
                            beta = min(beta, score)
                        }
                        if alpha >= beta {
                            return bestScore
                        }
                    case .draw:
                        return 0
                    case .win(let player):
                        return player is AIPlayer ? 10 - depth : -10 + depth
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }

        return bestScore
    }
}
