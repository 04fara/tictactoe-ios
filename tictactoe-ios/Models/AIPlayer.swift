//
//  AIPlayer.swift
//  tictactoe-ios
//
//  Created by F K on 07/02/2022.
//

enum AIPlayerDifficulty: String {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
}

class AIPlayer: Player {
    var difficulty: AIPlayerDifficulty

    init(with marker: Marker, difficulty: AIPlayerDifficulty) {
        self.difficulty = difficulty

        super.init(with: marker)
    }
}
