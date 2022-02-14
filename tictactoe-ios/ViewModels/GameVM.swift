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
    case .win(let player, _):
        title = "\(player.marker.rawValue) win (\(player is AIPlayer ? "AI" : "Human"))"
    case .draw:
        title = "Draw"
    }

    return title
}

class GameVM: BaseVM<GameInteractor> {
    let boardVM: BoardVM
    let status: BehaviorSubject<String>
    let isFinished: BehaviorSubject<Bool>
    var isAITurn: BehaviorSubject<Bool>

    override init(interactor: GameInteractor) {
        let boardInteractor = BoardInteractor(interactor.board)
        boardVM = .init(interactor: boardInteractor)
        status = .init(value: generateStatusFor(result: interactor.result))
        isFinished = .init(value: interactor.isGameFinished)
        isAITurn = .init(value: interactor.isAITurn)

        super.init(interactor: interactor)

        isAITurn
            .bind { [weak self] isAITurn in
                guard isAITurn else { return }

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) { [weak self] in
                    self?.interactor.isAITurn = false
                    self?.makeMove()
                }
            }
            .disposed(by: disposeBag)
    }
}

extension GameVM {
    func makeMove(at position: Int? = nil) {
        switch interactor.turn.makeMove(at: position) {
        case .success(let result):
            guard let position = interactor.madeMoves.last?.position else { return }

            status.onNext(generateStatusFor(result: result))
            isFinished.onNext(interactor.isGameFinished)
            boardVM.updateCellMarkerType(at: position)

            switch result {
            case .win(_, let winCombo):
                boardVM.highlightCellMarkers(at: winCombo)
            case .draw:
                boardVM.highlightCellMarkers(at: [])
            case .ongoing:
                isAITurn.onNext(interactor.isAITurn)
            }
        case .failure(let error):
            print(error)
        }
    }

    func reset() {
        interactor.reset()
        status.onNext(generateStatusFor(result: interactor.result))
        isFinished.onNext(interactor.isGameFinished)
        isAITurn.onNext(interactor.isAITurn)
        boardVM.reset()
    }
}
