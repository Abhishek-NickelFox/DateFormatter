//
//  ATTextField.swift
//  StringFormatters
//
//  Created by Abhishek on 08/07/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import UIKit

class ATDateTextField: UITextField  {
    
    public let seperator = "/"
    let empty = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.maxLength = 10
    }
}

extension ATDateTextField: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        let count = textField.text?.characters.count
        
        if count == 2 || count == 5 {
            if (string != empty) {
                textField.text = textField.text! + seperator
            }
        }
        
        let flag = (allowedCharacters.isSuperset(of: characterSet) || string == empty)
        return flag
    }
}

private var kAssociationKeyMaxLength: Int = 0

extension UITextField {
    
    var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.characters.count > maxLength
            else {
                return
        }
        
        let selection = selectedTextRange
        let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        text = prospectiveText.substring(to: maxCharIndex)
        selectedTextRange = selection
    }
}
