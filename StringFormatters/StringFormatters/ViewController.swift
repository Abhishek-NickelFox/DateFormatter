//
//  ViewController.swift
//  StringFormatters
//
//  Created by Abhishek on 03/07/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate  {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        txtField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let trivialDate = "33/33/33"
        let trivialDate2 = "12/12/12"
        let trivialDate3 = "31/12/33"
        
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd/MM/YY"
        
        let dd = dateformatter.date(from: trivialDate)
        if dd != nil {
            print("TESTED 1")
        }
        else {
            print("DO ANOTHER LOGIC 1")
        }
        
        let dd2 = dateformatter.date(from: trivialDate2)
        if dd2 != nil {
            print("TESTED 2")
        }
        else {
            print("DO ANOTHER LOGIC 2")
        }
        
        let dd3 = dateformatter.date(from: trivialDate3)
        if dd3 != nil {
            print("TESTED 3")
        }
        else {
            print("DO ANOTHER LOGIC 3")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func validate(_ sender: Any) {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "dd/MM/YY"
        
        if dateformatter.date(from: txtField.text!) != nil {
            print("VALID DATE")
            dateLabel.text = "VALID DATE"
        } else {
            print("INVALID DATE")
            dateLabel.text = "INVALID DATE"
        }
    }
    
    @IBOutlet weak var txtField: UITextField!

    @IBOutlet weak var dateLabel: UILabel!
    
    let seperator = "/"
    let empty = ""
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
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
    
    @IBInspectable var maxLength: Int {
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

extension String  {
    var isNumber : Bool {
        get{
            return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
        }
    }
}
