//
//  Cell.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

import Foundation

class Cell {
    let position: IndexPath
    var player: Player? = nil
    var isEmpty: Bool { return player == nil }

    var x: Int { return position.section }
    var y: Int { return position.item }

    init(at indexPath: IndexPath) {
        position = indexPath
    }
}

extension Cell {
    func reset() {
        player = nil
    }
}
