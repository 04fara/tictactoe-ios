//
//  BaseVM.swift
//  tictactoe-ios
//
//  Created by F K on 08/02/2022.
//

import RxSwift

protocol ViewModel {
    associatedtype Interactor

    var interactor: Interactor { get }
}

class BaseVM<Interactor: BaseInteractor>: ViewModel {
    var interactor: Interactor
    var disposeBag: DisposeBag = .init()

    init(interactor: Interactor) {
        self.interactor = interactor
    }
}
