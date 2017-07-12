//
//  UITextField+DateFormat.swift
//  StringFormatters
//
//  Created by Abhishek on 08/07/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import Foundation
import UIKit

enum SeperaterType: String {
	case slash = "/"
	case dot = "."
	case hyphon = "-"
}

private var kAssociationKeyMaxLength: Int = 0

class DateTextFormatter: NSObject {
	
	private var formatter: DateFormatter?
	private var dateFormat = ""
	private let empty = ""
	
	public var seperaterType: SeperaterType = .slash {
		didSet {
			let type = seperaterType.rawValue
			dateFormat = "dd" + type + "MM" + type + "YYYY"
		}
	}
	
	public override init() {
		
	}
	
	func textField(_ textField: UITextField, replacementString string: String) -> Bool {
		
		let allowedCharacters = CharacterSet.decimalDigits
		let characterSet = CharacterSet(charactersIn: string)
		let count = textField.text?.characters.count
		
		if count == 2 || count == 5 {
			if (string != empty) {
				textField.text = textField.text! + seperaterType.rawValue
			}
		}
		
		let flag = (allowedCharacters.isSuperset(of: characterSet) || string == empty)
		return flag
	}
	
	func isValidDate(text: String) -> Bool {
		return formatter!.date(from: text) != nil
	}
}

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
		guard let prospectiveText = self.text, prospectiveText.characters.count > maxLength else { return }
		let selection = selectedTextRange
		let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
		text = prospectiveText.substring(to: maxCharIndex)
		selectedTextRange = selection
	}
}
