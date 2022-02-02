//
//  Board.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

import Foundation

class Board {
    private var analyzer: BoardAnalyzer

    let size: Int = 3
    private(set) var cells: [[Cell]]
    private(set) var available: Int

    init() {
        analyzer = .init()
        cells = []
        available = size * size

        for x in 0..<size {
            var row = [Cell]()
            for y in 0..<size {
                let cell = Cell(at: [x, y])
                row.append(cell)
            }
            cells.append(row)
        }
    }
}

extension Board {
    func hasAvailableCells() -> Bool {
        return available > 0
    }

    func getCell(at indexPath: IndexPath) -> Cell {
        return cells[indexPath.section][indexPath.item]
    }

    private func isCellEmpty(at position: IndexPath) -> Bool {
        return getCell(at: position).isEmpty
    }

    func makeMove(_ move: Move) -> Result<[IndexPath]?, TicTacToeError> {
        guard hasAvailableCells() else {
            return .failure(.noAvailableCells)
        }

        guard isCellEmpty(at: move.position) else {
            return .failure(.cellOccupied)
        }

        analyzer.updateScores(after: move)
        getCell(at: move.position).player = move.player
        available -= 1

        return .success(analyzer.hasWinner())
    }

    func reset() {
        analyzer.reset()
        cells.forEach { row in
            row.forEach { cell in
                cell.reset()
            }
        }
        available = size * size
    }
}
