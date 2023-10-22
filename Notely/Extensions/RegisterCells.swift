//
//  RegisterCells.swift
//  Notely
//
//  Created by Quang Tran on 22/10/2023.
//

import UIKit

public extension UIView {
    static var reuseName: String {
        return String(describing: self)
    }
}

public extension UICollectionView {
    func register(cell: UICollectionViewCell.Type) {
        register(cell.self, forCellWithReuseIdentifier: cell.reuseName)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ cell: T.Type,
                                                      for indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: cell.reuseName, for: indexPath) as! T
    }
    
    func registerHeader(_ view: UICollectionReusableView.Type) {
        register(view.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: view.reuseName)
    }
    
    func dequeueReusableHeader<T: UICollectionReusableView>(_ view: T.Type,
                                                            for indexPath: IndexPath) -> T {
        dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                         withReuseIdentifier: view.reuseName, for: indexPath) as! T
    }
}

public extension UITableView {
    func register(cell: UITableViewCell.Type) {
        register(cell.self, forCellReuseIdentifier: cell.reuseName)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ cell: T.Type,
                                                 for indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: cell.reuseName,
                            for: indexPath) as! T
    }
}
