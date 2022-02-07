//
//  Game.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

class Game {
    private(set) var players: [Player]
    private(set) var board: Board
    private(set) var result: GameResult

    var isFinished: Bool {
        switch result {
        case .ongoing:
            return false
        case .win, .draw:
            return true
        }
    }

    init(with players: [Player]) {
        // guard players.count == 2 else { throw TicTacToeError.unknown }

        self.players = players
        board = .init(with: players)
        result = .ongoing(players[0])
    }
}

extension Game {
    func makeMove(at position: Int) -> Result<GameResult, TicTacToeError> {
        switch board.makeMove(at: position) {
        case .success(let result):
            self.result = result

            return .success(result)
        case .failure(let error):
            return .failure(error)
        }
    }

    func reset() {
        board = .init(with: players)
        result = .ongoing(players[0])
    }
}
