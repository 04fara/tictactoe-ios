//
//  BoardVM.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

import RxSwift

class BoardVM {
    let cells: [[CellVM]]

    init(board: Board) {
        var cells: [[CellVM]] = .init()
        for x in 0..<3 {
            var row: [CellVM] = .init()
            for y in 0..<3 {
                let cell = board.getCell(at: [x, y])
                let cellVM = CellVM(cell: cell)
                row.append(cellVM)
            }
            cells.append(row)
        }
        self.cells = cells
    }
}

extension BoardVM {
    func getCellVM(at position: IndexPath) -> CellVM {
        return cells[position.section][position.item]
    }

    func updateCellMarker(at position: IndexPath, with marker: Marker) {
        getCellVM(at: position).marker.onNext(marker)
    }

    func highlightCellMarkers(at positions: [IndexPath]) {
        cells.forEach { row in
            row.forEach { cell in
                let markerColor: MarkerColor
                if positions.contains(cell.position) {
                    markerColor = .winner
                } else {
                    markerColor = .disabled
                }
                cell.strokeColor.onNext(markerColor)
            }
        }
    }

    func reset() {
        cells.forEach { row in
            row.forEach { cell in
                cell.reset()
            }
        }
    }
}
