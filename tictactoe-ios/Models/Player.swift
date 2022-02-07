//
//  Player.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

enum Player {
    case human(Marker)
    case ai(Marker)

    var marker: Marker {
        switch self {
        case .human(let marker):
            return marker
        case .ai(let marker):
            return marker
        }
    }

    var isAI: Bool {
        switch self {
        case .ai:
            return true
        default:
            return false
        }
    }
}
