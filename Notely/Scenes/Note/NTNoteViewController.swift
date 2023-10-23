// 
//  NTNoteViewController.swift
//  Notely
//
//  Created by Quang Tran on 21/10/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Stevia

class NTNoteViewController: UIViewController {
    let viewModel: NTNoteViewModel

    lazy var textView = UITextView()
    
    init(viewModel: NTNoteViewModel) {
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }

    private func bindViewModel() {
        let textChange = textView.rx.didChange
            .compactMap { [weak self] _ in self?.textView.attributedText }
        
        let output = viewModel.transform(input: .init(
            attributedString: textChange
        ))
        
        output.attributedString
            .drive(textView.rx.attributedText)
            .disposed(by: rx.disposeBag)
        
        output.typingAttributes
            .drive(textView.rx.typingAttributes)
            .disposed(by: rx.disposeBag)
    }
}

extension NTNoteViewController {
    private func createViews() {
        view.subviews {
            textView
        }
        
        view.layout {
            0
            |textView|
            0
        }
    }

    private func setupViews() {
        textView.backgroundColor = R.color.background()
        textView.allowsEditingTextAttributes = true
    }
}
