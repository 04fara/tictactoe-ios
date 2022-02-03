//
//  GameVM.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

import RxSwift

private func generateStatus(from status: GameStatus) -> String {
    let turn: String
    switch status.result {
    case .ongoing:
        turn = "\(status.currentTurn.rawValue) turn"
    case .win:
        turn = "\(status.currentTurn.rawValue) win"
    case .draw:
        turn = "Draw"
    }

    return turn
}

class GameVM {
    let game: Game
    let currentTurn: BehaviorSubject<String>
    let result: BehaviorSubject<String>
    let boardVM: BoardVM

    init() {
        game = .init()
        currentTurn = .init(value: generateStatus(from: game.status))
        result = .init(value: game.status.result.rawValue)
        boardVM = .init(board: game.board)
    }
}

extension GameVM {
    @discardableResult
    func makeMove(at indexPath: IndexPath) -> Bool? {
        if let error = game.makeMove(at: indexPath) {
            switch error {
            case .gameFinished, .noAvailableCells:
                return nil
            default:
                return false
            }
        }

        result.onNext(game.status.result.rawValue)
        currentTurn.onNext(generateStatus(from: game.status))

        if let player = game.board.getCell(at: indexPath).player {
            let marker: Marker = player == .circle ? .circle : .cross
            boardVM.updateCellMarker(at: indexPath, with: marker)
        }

        switch game.status.result {
        case .win, .draw:
            guard let winnerCombo = game.status.winnerCombo else { return false }

            boardVM.highlightCellMarkers(at: winnerCombo)
        default:
            break
        }

        return true
    }

    func reset() {
        game.reset()
        currentTurn.onNext(generateStatus(from: game.status))
        result.onNext(game.status.result.rawValue)
        boardVM.reset()
    }
}
