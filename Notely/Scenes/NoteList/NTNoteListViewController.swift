// 
//  NTNoteListViewController.swift
//  Notely
//
//  Created by Quang Tran on 21/10/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Stevia

class NTNoteListViewController: UIViewController {
    let viewModel: NTNoteListViewModel
    lazy var searchBar = UISearchBar()
    lazy var titleLabel = UILabel()
    lazy var tableView = UITableView()
    
    init(viewModel: NTNoteListViewModel) {
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
    }
}

extension NTNoteListViewController {
    private func createViews() {
        view.subviews {
            searchBar
            tableView
        }
        
        
        view.layout {
            searchBar
            |tableView|
            0
        }
        
        |-20-searchBar-20-|
        
        searchBar.Top == view.safeAreaLayoutGuide.Top
    }

    private func setupViews() {
        titleLabel.style {
            $0.font = .boldAppFont(ofSize: 24)
            $0.textColor = .AppColor.accent
            $0.text = R.string.localizable.home_title()
        }
        
        searchBar.style {
            $0.backgroundImage = UIImage()
        }
        
        tableView.style {
            $0.backgroundColor = .darkGray
        }
        
        let titleItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItem = titleItem
    }
}

import SwiftUI
struct NoteList: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        return UINavigationController(
            rootViewController: NTNoteListNavigator().makeViewController()
        )
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
#Preview {
    NoteList()
        .ignoresSafeArea()
}
