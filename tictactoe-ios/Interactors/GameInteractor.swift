//
//  GameInteractor.swift
//  tictactoe-ios
//
//  Created by F K on 08/02/2022.
//

enum GameMode: String {
    case local = "Local"
    case aiEasy = "Easy"
    case aiMedium = "Medium"
    case aiHard = "Hard"
    case multipeer = "Multipeer"
}

class GameInteractor: BaseInteractor {
    private let game: Game

    var board: Board {
        return game.board
    }

    var madeMovesCount: Int {
        return game.madeMovesCount
    }

    var madeMoves: [Move] {
        return game.madeMoves
    }

    var players: [Player] {
        return game.players
    }

    private(set) lazy var playerInteractors: [PlayerInteractor] = players.map { player in
        switch player {
        case is HumanPlayer:
            return HumanPlayerInteractor(with: player, gameInteractor: self)
        case is AIPlayer:
            return AIPlayerInteractor(with: player, gameInteractor: self)
        default:
            return PlayerInteractor(with: player, gameInteractor: self)
        }
    }

    var result: GameResult {
        return game.result
    }

    var turn: PlayerInteractor {
        return playerInteractors[madeMovesCount % 2]
    }

    lazy var isAITurn: Bool = turn.player is AIPlayer

    var isGameFinished: Bool {
        switch game.result {
        case .ongoing:
            return false
        case .win, .draw:
            return true
        }
    }

    init(mode: GameMode) {
        let players: [Player]
        switch mode {
        case .local:
            players = [HumanPlayer(with: .circle), HumanPlayer(with: .cross)]
        case .aiEasy, .aiMedium, .aiHard:
            guard let aiDifficulty: AIPlayerDifficulty = .init(rawValue: mode.rawValue)
            else {
                players = []
                break
            }
            players = [HumanPlayer(with: .circle), AIPlayer(with: .cross, difficulty: aiDifficulty)]
        case .multipeer:
            players = []
        }

        game = .init(with: players)
    }
}

extension GameInteractor {
    func attemptMove(at position: Int) -> Result<GameResult, TicTacToeError> {
        guard !isGameFinished else { return .failure(.gameFinished) }
        guard !isAITurn else { return .failure(.aiTurn) }
        guard board.isCellEmpty(at: position) else { return .failure(.cellOccupied) }

        makeMove(at: position)

        return .success(result)
    }

    func makeMove(at position: Int) {
        let move = Move(player: turn.player, position: position)
        let marker = move.player.marker
        game.madeMovesCount += 1
        game.madeMoves.append(move)
        board.updateCell(at: position, with: marker)
        updateResult()
    }

    func undoLastMove() {
        guard madeMovesCount > 0 else { return }

        game.madeMovesCount -= 1
        let move = game.madeMoves.removeLast()
        let position = move.position
        board.clearCell(at: position)
        updateResult()
    }

    func reset() {
        game.reset()
    }
}

extension GameInteractor {
    func updateResult() {
        guard let lastMove = madeMoves.last else {
            game.result = .ongoing(turn.player)

            return
        }

        let state: [Int] = board.cells.map { cell in
            switch cell {
            case .marked(let marker):
                return marker == lastMove.player.marker ? 1 : 0
            case .empty:
                return 0
            }
        }

        let winCombos = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8],
            [0, 3, 6], [1, 4, 7], [2, 5, 8],
            [0, 4, 8], [2, 4, 6]
        ]
        for winCombo in winCombos {
            var score = 0
            for i in winCombo {
                score += state[i]
            }

            if score == 3 {
                game.result = .win(lastMove.player, winCombo)

                return
            }
        }

        game.result = madeMovesCount == Board.Const.count ? .draw : .ongoing(turn.player)
        isAITurn = turn.player is AIPlayer
    }
}
