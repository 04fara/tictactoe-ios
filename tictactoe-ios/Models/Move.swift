//
//  Move.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

import Foundation

struct Move {
    let position: IndexPath
    let player: Player

    var x: Int { return position.section }
    var y: Int { return position.item }

    init(at position: IndexPath, with marker: Player) {
        self.position = position
        self.player = marker
    }
}
