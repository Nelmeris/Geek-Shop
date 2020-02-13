//
//  GenderPicker.swift
//  GeekShop
//
//  Created by Artem Kufaev on 12.02.2020.
//  Copyright © 2020 Artem Kufaev. All rights reserved.
//

import Foundation
import UIKit

class GenderPicker: UITextField {
        
    var genderPicker: UIPickerView!
    
    let genders = ["Male", "Female"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureGenderPicker()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureGenderPicker()
    }
    
    func configureGenderPicker() {
        genderPicker = UIPickerView()
        genderPicker.dataSource = self
        genderPicker.delegate = self

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneGenderPicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([spaceButton, doneButton], animated: false)
        self.inputAccessoryView = toolbar
        self.inputView = genderPicker
    }

    @objc func doneGenderPicker() {
        self.endEditing(true)
    }
    
}

extension GenderPicker: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.text = genders[row]
    }
    
}
