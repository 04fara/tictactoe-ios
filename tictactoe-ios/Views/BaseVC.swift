//
//  BaseVC.swift
//  tictactoe-ios
//
//  Created by F K on 08/02/2022.
//

import UIKit
import RxSwift

class BaseVC<VM: ViewModel>: UIViewController {
    let disposeBag: DisposeBag = .init()
    let viewModel: VM

    init(viewModel: VM) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
