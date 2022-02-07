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
        title = "\(player.marker.rawValue) turn (\(player is AIPlayer ? "AI" : "Human"))"
    case .win(let player):
        title = "\(player.marker.rawValue) win (\(player is AIPlayer ? "AI" : "Human"))"
    case .draw:
        title = "Draw"
    }

    return title
}

class GameVM {
    let game: Game
    let boardVM: BoardVM
    let status: BehaviorSubject<String>
    let isFinished: BehaviorSubject<Bool>
    var isAITurn: Bool

    init(with game: Game) {
        self.game = game
        boardVM = .init(board: game.board)
        status = .init(value: generateStatusFor(result: game.result))
        isFinished = .init(value: game.isFinished)
        isAITurn = game.board.turn is AIPlayer
    }
}

extension GameVM {
    func makeMove(at position: Int) {
        guard !isAITurn else {
            print("AITurn!")
            return
        }

        switch game.makeMove(at: position) {
        case .success(let result):
            status.onNext(generateStatusFor(result: result))
            isFinished.onNext(game.isFinished)
            boardVM.board = game.board
            boardVM.updateCellMarkerType(at: position)

            switch result {
            case .win, .draw:
                boardVM.highlightCellMarkers(at: game.board.analyzer.winCombo ?? [])
            case .ongoing(let player):
                isAITurn = player is AIPlayer
                if let player = player as? AIPlayer,
                   let position = AIBot.makeMove(on: game.board, with: player.difficulty) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { [weak self] in
                        self?.isAITurn = false
                        self?.makeMove(at: position)
                    }
                }
            }
        case .failure(let error):
            print(error)
        }
    }

    func reset() {
        game.reset()
        status.onNext(generateStatusFor(result: game.result))
        isFinished.onNext(game.isFinished)
        boardVM.board = game.board
        boardVM.reset()
    }
}
