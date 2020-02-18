//
//  ScrollableKeyboard.swift
//  GeekShop
//
//  Created by Artem Kufaev on 12.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    internal func registerForKeyboardNotifications(with scrollView: UIScrollView) {
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillShowNotification, object: scrollView)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: scrollView)
    }
    
    internal func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    private func adjustForKeyboard(_ notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let scrollView = notification.object as? UIScrollView else { return }

        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        let keyboardHeight = keyboardViewEndFrame.height - view.safeAreaInsets.bottom
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            scrollView.contentInset = .zero
        } else {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        }
    }
    
}
