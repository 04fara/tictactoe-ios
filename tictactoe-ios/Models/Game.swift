//
//  Game.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

class Game {
    var board: Board
    var madeMovesCount: Int
    var madeMoves: [Move]
    var players: [Player]
    var result: GameResult

    init(with players: [Player]) {
        // guard players.count == 2 else { throw TicTacToeError.unknown }
        board = .init()
        madeMovesCount = 0
        madeMoves = []
        self.players = players
        result = .ongoing(players[0])
    }

    func reset() {
        board.reset()
        madeMovesCount = 0
        madeMoves = []
        result = .ongoing(players[0])
    }
}
