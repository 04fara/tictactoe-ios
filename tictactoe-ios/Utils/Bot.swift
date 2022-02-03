//
//  Bot.swift
//  tictactoe-ios
//
//  Created by F K on 03/02/2022.
//

import Foundation

protocol Bot {
    func makeMove() -> IndexPath
    func reset()
}
