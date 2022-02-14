//
//  BoardVM.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

import RxSwift

class BoardVM: BaseVM<BoardInteractor> {
    let cells: [CellVM]

    override init(interactor: BoardInteractor) {
        var cellsVM: [CellVM] = .init()
        interactor.cells.enumerated().forEach {
            cellsVM.append(.init(cell: $0.element, at: $0.offset))
        }
        self.cells = cellsVM

        super.init(interactor: interactor)
    }
}

extension BoardVM {
    func getCellVM(at position: Int) -> CellVM {
        return cells[position]
    }

    func updateCellMarkerType(at position: Int) {
        let markerType: MarkerType
        switch interactor.getCell(at: position) {
        case .marked(let marker):
            markerType = marker == .circle ? .circle : .cross
        case .empty:
            markerType = .none
        }
        cells[position].markerType.onNext(markerType)
    }

    func highlightCellMarkers(at positions: [Int]) {
        cells.forEach { cell in
            let markerColor: MarkerColor = positions.contains(cell.position) ? .winner : .disabled
            cell.strokeColor.onNext(markerColor)
        }
    }

    func reset() {
        cells.forEach { cell in
            cell.reset()
        }
    }
}
