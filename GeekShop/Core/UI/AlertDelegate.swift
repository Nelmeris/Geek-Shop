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
    
    func showAlert(title: String, message: String? = nil, action: ((UIAlertAction) -> ())? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okTitle = R.string.localizable.standartOKButton()
            let action = UIAlertAction(title: okTitle, style: .default, handler: action)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showQuestion(title: String, message: String? = nil,
                      actions: (((UIAlertAction) -> ())?, ((UIAlertAction) -> ())?)? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okTitle = R.string.localizable.standartOKButton()
            let actionOk = UIAlertAction(title: okTitle, style: .default, handler: actions?.0)
            let cancelTitle = R.string.localizable.standartCancelButton()
            let actionCancel = UIAlertAction(title: cancelTitle, style: .destructive, handler: actions?.1)
            alert.addAction(actionOk)
            alert.addAction(actionCancel)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
