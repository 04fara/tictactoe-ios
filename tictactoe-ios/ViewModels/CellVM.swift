//
//  CellVM.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

import RxSwift

class CellVM {
    let position: Int
    let markerType: BehaviorSubject<MarkerType>
    let strokeColor: BehaviorSubject<MarkerColor>

    init(cell: Cell, at position: Int) {
        self.position = position
        let markerType: MarkerType
        switch cell {
        case .marked(let marker):
            markerType = marker == .circle ? .circle : .cross
        case .empty:
            markerType = .none
        }
        self.markerType = .init(value: markerType)
        strokeColor = .init(value: .normal)
    }
}

extension CellVM {
    func reset() {
        markerType.onNext(.none)
        strokeColor.onNext(.normal)
    }
}
