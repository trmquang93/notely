// 
//  NTRandomBackgroundViewController.swift
//  Notely
//
//  Created by Quang Tran on 24/10/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Stevia

class NTRandomBackgroundViewController: UIViewController {
    let viewModel: NTRandomBackgroundViewModel
    lazy var imageView = UIImageView()
    lazy var coverView = UIView()
    
    init(viewModel: NTRandomBackgroundViewModel) {
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
        let viewSize = rx.viewHasSize
            .compactMap { [weak self] in self?.view.bounds.size }
        
        let output = viewModel.transform(input: .init(
            viewSize: viewSize
        ))
        
        output.image
            .drive(imageView.rx.image)
            .disposed(by: rx.disposeBag)
    }
}

extension NTRandomBackgroundViewController {
    private func createViews() {
        view.subviews {
            imageView
            coverView
        }
        
        imageView
            .fillContainer()
        
        coverView
            .fillContainer()
    }

    private func setupViews() {
        imageView.style {
            $0.contentMode = .scaleAspectFill
        }
        
        coverView.style {
            $0.backgroundColor = R.color.background()?.withAlphaComponent(0.85)
        }
    }
}
