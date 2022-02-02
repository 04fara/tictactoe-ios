//
//  TicTacToeError.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

// MARK: TODO put messages into TicTacToeError
enum TicTacToeError: Error {
    case gameFinished
    case noAvailableCells
    case cellOccupied
    case unknown
}
