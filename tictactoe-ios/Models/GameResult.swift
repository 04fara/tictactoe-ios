//
//  GameResult.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 07/02/2022.
//

enum GameResult {
    case ongoing(Player)
    case win(Player, [Int])
    case draw
}
