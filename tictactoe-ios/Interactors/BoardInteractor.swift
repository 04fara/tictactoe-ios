//
//  BoardInteractor.swift
//  tictactoe-ios
//
//  Created by F K on 08/02/2022.
//

class BoardInteractor: BaseInteractor {
    private let board: Board

    var cells: [Cell] {
        return board.cells
    }

    init(_ board: Board) {
        self.board = board
    }
}

extension BoardInteractor {
    func getCell(at position: Int) -> Cell {
        return board.getCell(at: position)
    }

    private func isCellEmpty(at position: Int) -> Bool {
        return board.isCellEmpty(at: position)
    }
}
