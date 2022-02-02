//
//  GameVC.swift
//  tictactoe-ios
//
//  Created by Farid Kopzhassarov on 02/02/2022.
//

import UIKit
import RxSwift
import RxCocoa

private func getLargeTitleView(of navigationController: UINavigationController?) -> UILabel? {
    var label: UILabel?
    navigationController?.navigationBar.subviews.forEach { a in
        if let c = NSClassFromString("_UINavigationBarLargeTitleView"),
           a.isKind(of: c.self) {
            label = a.subviews.first as? UILabel

            return
        }
    }

    return label
}

class GameVC: UIViewController {
    private let gameVM: GameVM = .init()
    private let disposeBag: DisposeBag = .init()

    private let boardVC: BoardVC = {
        let boardVC = BoardVC()
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false

        return boardVC
    }()

    private var boardView: BoardView {
        return boardVC.view as! BoardView
    }

    private lazy var navBarLargeLabel: UILabel? = getLargeTitleView(of: navigationController)

    private var rightBarButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentHorizontalAlignment = .trailing
        button.setTitle("Reset", for: .normal)
        button.alpha = 0

        return button
    }()

    private var shouldAnimateTitleChanges: Bool = false

    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        view.addSubview(boardVC.view)

        rightBarButton.addTarget(self, action: #selector(handleResetTap), for: .touchUpInside)

        bind()
    }

    override func viewWillLayoutSubviews() {
        if let navBarLargeLabel = navBarLargeLabel,
           let navBarLargeLabelParent = navBarLargeLabel.superview {
            navBarLargeLabelParent.addSubview(rightBarButton)
            NSLayoutConstraint.activate([
                rightBarButton.centerYAnchor.constraint(equalTo: navBarLargeLabelParent.centerYAnchor),
                rightBarButton.heightAnchor.constraint(equalTo: navBarLargeLabelParent.heightAnchor),
                rightBarButton.trailingAnchor.constraint(equalTo: navBarLargeLabelParent.layoutMarginsGuide.trailingAnchor)
            ])
        }

        NSLayoutConstraint.activate([
            boardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            boardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            boardView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -60),
            boardView.heightAnchor.constraint(equalTo: boardView.widthAnchor)
        ])
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        hideResetButton(animated: false)
    }

    deinit {
        rightBarButton.removeFromSuperview()
    }
}

extension GameVC {
    private func bind() {
        boardVC.boardVM = gameVM.boardVM
        boardVC.makeMove = { [weak self] indexPath in
            self?.gameVM.makeMove(at: indexPath)
        }

        gameVM.currentTurn
            .bind { [weak self] in
                self?.changeTitle($0, animated: self?.shouldAnimateTitleChanges ?? false)
                self?.shouldAnimateTitleChanges = false
            }
            .disposed(by: disposeBag)

        gameVM.result
            .bind { [weak self] in
                switch $0 {
                case "draw":
                    self?.showResetButton()
                case "win":
                    self?.showResetButton()
                default:
                    self?.hideResetButton()
                }
            }
            .disposed(by: disposeBag)
    }

    private func showResetButton(animated: Bool = true) {
        if animated {
            UIView.animate(withDuration: 0.25) {
                self.rightBarButton.alpha = 1
            }
        } else {
            rightBarButton.alpha = 1
        }
    }

    private func hideResetButton(animated: Bool = true) {
        if animated {
            UIView.animate(withDuration: 0.25) {
                self.rightBarButton.alpha = 0
            }
        } else {
            rightBarButton.alpha = 0
        }
    }

    private func changeTitle(_ title: String, animated: Bool = true) {
        if animated,
           let navBarLargeLabel = navBarLargeLabel {
            UIView.transition(with: navBarLargeLabel, duration: 0.5, options: [.curveEaseInOut, .transitionFlipFromLeft]) {
                self.title = title
            }
        } else {
            self.title = title
        }
    }

    @objc private func handleResetTap() {
        shouldAnimateTitleChanges = true
        gameVM.reset()
    }
}
