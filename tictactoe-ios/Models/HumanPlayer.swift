//
//  Player.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

protocol Player {
    var marker: Marker { get }
}

struct HumanPlayer: Player {
    var marker: Marker

    init(with marker: Marker) {
        self.marker = marker
    }
}
