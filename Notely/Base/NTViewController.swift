//
//  NTViewController.swift
//  Notely
//
//  Created by Quang Tran on 24/10/2023.
//

import UIKit

class NTViewController: UIViewController {
    var preferredNavigationBarHidden: Bool {
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if parent is UINavigationController {
            navigationController?.setNavigationBarHidden(
                preferredNavigationBarHidden,
                animated: animated)
        }
    }

}
