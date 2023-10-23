// 
//  NTPadRootViewController.swift
//  Notely
//
//  Created by Quang Tran on 24/10/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Stevia

class NTPadRootViewController: UIViewController {
    let viewModel: NTPadRootViewModel
    
    lazy var noteListView = UIView()
    lazy var separator = UIView()
    lazy var noteDetailView = UIView()

    init(viewModel: NTPadRootViewModel) {
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
        
        output.noteList
            .drive(rx.child(in: noteListView))
            .disposed(by: rx.disposeBag)
        
        output.noteDetail
            .drive(rx.child(in: noteDetailView))
            .disposed(by: rx.disposeBag)
    }
}

extension NTPadRootViewController {
    private func createViews() {
        view.subviews {
            noteListView
            noteDetailView
            separator
        }
        
        view.layout {
            0
            |noteListView-0-separator-0-noteDetailView|
            0
        }
        
        noteListView
            .width(30%)
            .width(<=300)
        
        noteDetailView
            .fillVertically()
        
        separator
            .width(1)
            .fillVertically()
    }

    private func setupViews() {
        view.backgroundColor = R.color.background()
        
        separator.backgroundColor = R.color.secondaryBackground()
    }
}
