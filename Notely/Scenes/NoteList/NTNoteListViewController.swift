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
    lazy var createNewButton = UIButton()
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.contentInset.bottom = (view.bounds.height - createNewButton.frame.minY)
    }

    private func bindViewModel() {
        let selected = tableView.rx.itemSelected.map { $0.row }
        let output = viewModel.transform(input: .init(
            selected: selected,
            createNewTrigger: createNewButton.rx.tap.asObservable()))
        
        output.items
            .drive(tableView.rx.items) { tableView, index, item in
                let indexPath = IndexPath(row: index, section: 0)
                let cell = tableView.dequeueReusableCell(NTNoteCell.self, for: indexPath)
                cell.bind(viewModel: item)
                return cell
            }
            .disposed(by: rx.disposeBag)
        
        output.pushable
            .emit(to: rx.pushable)
            .disposed(by: rx.disposeBag)
    }
}

extension NTNoteListViewController {
    private func createViews() {
        view.subviews {
            searchBar
            tableView
            createNewButton
        }
        
        view.layout {
            searchBar
            |tableView|
            0
        }
        
        |-20-searchBar-20-|
        
        createNewButton
            .trailing(30)
            .size(50)
        
        createNewButton.Bottom == view.safeAreaLayoutGuide.Bottom - 30
        searchBar.Top == view.safeAreaLayoutGuide.Top
    }

    private func setupViews() {
        view.backgroundColor = R.color.background()
        
        titleLabel.style {
            $0.font = .boldAppFont(ofSize: 24)
            $0.textColor = R.color.accentColor()
            $0.text = R.string.localizable.home_title()
        }
        
        searchBar.style {
            $0.backgroundImage = UIImage()
        }
        
        createNewButton.style {
            $0.setImage(R.image.create_note(), for: .normal)
        }
        
        tableView.style {
            $0.register(cell: NTNoteCell.self)
            $0.backgroundColor = .clear
            $0.separatorStyle = .none
        }
        
        tableView.rx.itemSelected
            .subscribe(onNext: {[weak self] indexPath in
                self?.tableView.deselectRow(at: indexPath, animated: true)
            })
            .disposed(by: rx.disposeBag)
        
        let titleItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItem = titleItem
    }
}
