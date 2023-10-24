// 
//  NTPhoneRootViewController.swift
//  Notely
//
//  Created by Quang Tran on 24/10/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Stevia

class NTPhoneRootViewController: NTViewController {
    override var preferredNavigationBarHidden: Bool { true }
    
    let viewModel: NTPhoneRootViewModel
    lazy var backgroundView = UIView()
    lazy var contentView = UIView()

    init(viewModel: NTPhoneRootViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createViews()
        setupViews()
        bindViewModel()
    }

    private func bindViewModel() {
        let output = viewModel.transform(input: .init())
        
        output.background
            .drive(rx.child(in: backgroundView))
            .disposed(by: rx.disposeBag)
        
        output.content
            .drive(rx.child(in: contentView))
            .disposed(by: rx.disposeBag)
        
        output.pushable
            .emit(to: rx.pushable)
            .disposed(by: rx.disposeBag)
    }
}

extension NTPhoneRootViewController {
    private func createViews() {
        view.subviews {
            backgroundView
            contentView
        }
        
        backgroundView
            .fillContainer()
        
        contentView
            .fillContainer()
    }

    private func setupViews() {
    }
}
