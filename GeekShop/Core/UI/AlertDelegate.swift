//
//  AlertDelegate.swift
//  GeekShop
//
//  Created by Artem Kufaev on 13.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit

protocol AlertDelegate: UIViewController {
    func showAlert(title: String, message: String?, action: ((UIAlertAction) -> Void)?)
}

extension AlertDelegate {
    
    func showAlert(title: String, message: String? = nil, action: ((UIAlertAction) -> Void)? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
            let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: action)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
