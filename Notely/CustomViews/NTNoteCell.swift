// 
//  NTNoteCell.swift
//  Notely
//
//  Created by Quang Tran on 22/10/2023.
//

import UIKit
import RxSwift
import RxCocoa
import Stevia
import NSObject_Rx

class NTNoteCell: UITableViewCell {
    var disposeBag = DisposeBag()
    
    lazy var containerView = UIView()
    lazy var titleLabel = UILabel()
    lazy var timeStampLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createViews()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
}

extension NTNoteCell {
    func bind(viewModel: NTNoteCellViewModel) {
        viewModel.lastEditDateString
            .drive(timeStampLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.title
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

extension NTNoteCell {
    private func createViews() {
        contentView.subviews {
            containerView.subviews {
                titleLabel
                timeStampLabel
            }
        }
        
        containerView
            .fillVertically(padding: 15)
            .fillHorizontally(padding: 30)
        
        containerView.layout {
            10
            |-40-titleLabel-40-|
            |-40-timeStampLabel-40-|
            10
        }
        
        titleLabel.Height == timeStampLabel.Height
    }
    
    private func setupViews() {
        selectionStyle = .none
        
        containerView.style {
            $0.backgroundColor = .AppColor.secondaryBackground
            $0.layer.cornerRadius = 20
            $0.clipsToBounds = true
        }
        
        titleLabel.style {
            $0.font = .boldAppFont(ofSize: 18)
            $0.textColor = .AppColor.text
        }
        
        timeStampLabel.style {
            $0.font = .appFont(ofSize: 12)
            $0.textColor = .AppColor.text
        }
    }
}

struct NTNoteCellViewModel {
    let title: Driver<String>
    let lastEditDate: Driver<Date>
    
    var lastEditDateString: Driver<String> {
        return lastEditDate
            .map { date in
                let dateFormatted = DateFormatter.fullName.string(from: date)
                return R.string.localizable.last_edit_date(dateFormatted)
            }
    }
}

import SwiftUI
fileprivate
struct NoteListCell: UIViewRepresentable {
    typealias UIViewType = NTNoteCell
    
    func makeUIView(context: Context) -> NTNoteCell {
        return .init()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.bind(viewModel: .init(
            title: .just("Title"),
            lastEditDate: .just(Date())))
    }
}

#Preview {
    NoteListCell()
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: 120)
}
