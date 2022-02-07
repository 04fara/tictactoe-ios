//
//  Cell.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

enum Cell {
    case marked(Marker)
    case empty
}

extension Cell: Equatable {
    static func ==(lhs: Cell, rhs: Cell) -> Bool {
        switch (lhs, rhs) {
        case (.empty, .empty):
            return true
        case (.marked(let lMarker), .marked(let rMarker)):
            return lMarker == rMarker
        default:
            return false
        }
    }
}
