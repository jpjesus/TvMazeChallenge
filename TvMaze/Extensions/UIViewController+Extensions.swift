//
//  UIViewController+Extensions.swift
//  TvMaze
//
//  Created by Jesus Parada on 4/04/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    static func showOfflineAlert(with navigation: UINavigationController?) {
        let alertController = UIAlertController(title: NSLocalizedString("Error", comment: "Error"), message: NSLocalizedString("Error fetching the news", comment: "Error fetching the news"), preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(action)
        if let navigation = navigation?.visibleViewController {
            if !(navigation.isKind(of: UIAlertController.self)) {
                OperationQueue.main.addOperation {
                    navigation.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
