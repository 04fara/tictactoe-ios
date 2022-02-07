//
//  Bot.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 03/02/2022.
//

protocol Bot {
    static func makeMove(on board: Board, with difficulty: AIPlayerDifficulty) -> Int?
}
