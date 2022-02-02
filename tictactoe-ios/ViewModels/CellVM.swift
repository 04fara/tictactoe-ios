//
//  CellVM.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

import RxSwift

class CellVM {
    let position: IndexPath
    let marker: BehaviorSubject<Marker>
    let strokeColor: BehaviorSubject<MarkerColor>

    init(cell: Cell) {
        position = cell.position

        switch cell.player {
        case .circle:
            marker = .init(value: .circle)
        case .cross:
            marker = .init(value: .cross)
        default:
            marker = .init(value: .none)
        }

        strokeColor = .init(value: .normal)
    }
}

extension CellVM {
    func reset() {
        marker.onNext(.none)
        strokeColor.onNext(.normal)
    }
}
