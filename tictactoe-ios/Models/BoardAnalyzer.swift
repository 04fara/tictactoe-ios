//
//  BoardAnalyzer.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

struct BoardAnalyzer {
    private var scores: [Int]
    private(set) var winComboIdx: Int?
    var winCombo: [Int]? {
        guard let winComboIdx = winComboIdx else { return nil }

        let winCombo: [Int]?
        switch winComboIdx {
        case 0, 1, 2:
            winCombo = [0, 1, 2].map { $0 + winComboIdx * 3 }
        case 3, 4, 5:
            winCombo = [0, 3, 6].map { $0 + winComboIdx % 3 }
        case 6:
            winCombo = [0, 4, 8]
        case 7:
            winCombo = [2, 4, 6]
        default:
            winCombo = nil
        }

        return winCombo
    }

    init() {
        scores = .init(repeating: 0, count: 8)
    }
}

extension BoardAnalyzer {
    mutating func updateScores(after move: Int, of marker: Marker) {
        let x = move / 3
        let y = move % 3
        let val = marker == .circle ? 1 : -1

        scores[x] += val
        scores[y + 3] += val
        scores[6] += val * (x == y ? 1 : 0)
        scores[7] += val * (x + y == 2 ? 1 : 0)

        winComboIdx = scores.enumerated()
            .filter { $1 == 3 || $1 == -3 }
            .map { $0.offset }
            .first
    }
}
