//
//  Board.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 06/02/2022.
//

struct Board {
    private struct Const {
        static let rows: Int = 3
        static let cols: Int = 3
        static var count: Int { return rows * cols }
    }

    let players: [Player]
    var analyzer: BoardAnalyzer
    var available: Int
    var cells: [Cell]
    var turn: Player {
        return players[(Const.count - available) % 2]
    }

    init(with players: [Player]) {
        self.players = players
        analyzer = .init()
        available = Const.count
        cells = .init(repeating: .empty, count: Const.count)
    }
}

extension Board {
    func getCell(at position: Int) -> Cell {
        return cells[position]
    }

    private func isCellEmpty(at position: Int) -> Bool {
        return getCell(at: position) == .empty
    }

    mutating func makeMove(at position: Int) -> Result<GameResult, TicTacToeError> {
        guard analyzer.winCombo == nil || available == 0 else { return .failure(.gameFinished) }
//        guard !(turn is AIPlayer) else { return .failure(.aiTurn) }
        guard isCellEmpty(at: position) else { return .failure(.cellOccupied) }

        analyzer.updateScores(after: position, of: turn.marker)
        cells[position] = .marked(turn.marker)

        switch analyzer.winCombo {
        case .some:
            return .success(.win(turn))
        case .none:
            available -= 1

            return .success(available > 0 ? .ongoing(turn) : .draw)
        }
    }
}
