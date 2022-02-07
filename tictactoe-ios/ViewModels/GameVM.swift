//
//  GameVM.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

import RxSwift

private func generateStatusFor(result: GameResult) -> String {
    let title: String
    switch result {
    case .ongoing(let player):
        title = "\(player.marker.rawValue) turn"
    case .win(let player):
        title = "\(player.marker.rawValue) win"
    case .draw:
        title = "Draw"
    }

    return title
}

class GameVM {
    let game: Game
    let boardVM: BoardVM
    let status: BehaviorSubject<String>

    init(with game: Game) {
        self.game = game
        boardVM = .init(board: game.board)
        status = .init(value: generateStatusFor(result: game.result))
    }
}

extension GameVM {
    func makeMove(at position: Int) {
        switch game.makeMove(at: position) {
        case .success(let result):
            print(result)
            status.onNext(generateStatusFor(result: result))
            boardVM.board = game.board
            boardVM.updateCellMarkerType(at: position)

            switch result {
            case .win, .draw:
                boardVM.highlightCellMarkers(at: game.board.analyzer.winCombo ?? [])
            default:
                break
            }
        case .failure(let error):
            print(error)
        }
    }

    func reset() {
        game.reset()
        status.onNext(generateStatusFor(result: game.result))
        boardVM.board = game.board
        boardVM.reset()
    }
}
