//
//  AIPlayer.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 07/02/2022.
//

enum AIPlayerDifficulty: String {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}

struct AIPlayer: Player {
    var marker: Marker
    var difficulty: AIPlayerDifficulty

    init(with marker: Marker, difficulty: AIPlayerDifficulty) {
        self.marker = marker
        self.difficulty = difficulty
    }
}
