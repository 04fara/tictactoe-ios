//
//  Board.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 06/02/2022.
//

class Board {
    struct Const {
        static let rows: Int = 3
        static let cols: Int = 3
        static var count: Int { return rows * cols }
    }

    var cells: [Cell]

    init() {
        cells = .init(repeating: .empty, count: Const.count)
    }

    func reset() {
        cells = .init(repeating: .empty, count: Const.count)
    }

    func getCell(at position: Int) -> Cell {
        return cells[position]
    }

    func isCellEmpty(at position: Int) -> Bool {
        return getCell(at: position) == .empty
    }

    func updateCell(at position: Int, with marker: Marker) {
        cells[position] = .marked(marker)
    }

    func clearCell(at position: Int) {
        cells[position] = .empty
    }
}
