//
//  BoardVC.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

import UIKit
import RxSwift
import RxCocoa

class BoardVC: UIViewController {
    weak var boardVM: BoardVM?
    var makeMove: ((IndexPath) -> ())?
    private let disposeBag: DisposeBag = .init()

    private var cellSize: CGSize!
    private var cellSpacing: CGFloat!

    override func loadView() {
        let view = BoardView()
        view.delegate = self
        view.dataSource = self

        self.view = view
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        let minCellSpacing = CGFloat(5),
            availableWidth = view.bounds.width - 2 * minCellSpacing,
            cellWidth = (availableWidth / 3).rounded(.toNearestOrAwayFromZero)
        cellSpacing = minCellSpacing + (availableWidth - 3 * cellWidth) / 2
        cellSize = .init(width: cellWidth, height: cellWidth)
    }
}

extension BoardVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return .zero
        default:
            return .init(top: cellSpacing, left: 0, bottom: 0, right: 0)
        }
    }
}

extension BoardVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        var shouldSelect = true
        collectionView.visibleCells.forEach { cell in
            if !cell.contentView.isUserInteractionEnabled {
                shouldSelect = false

                return
            }
        }

        return shouldSelect
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        makeMove?(indexPath)
    }
}

extension BoardVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: BoardCollectionViewCell.self),
            for: indexPath
        ) as! BoardCollectionViewCell

        let cellVM = boardVM?.getCellVM(at: indexPath)
        cell.configure(cellVM)

        return cell
    }
}
