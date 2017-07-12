//
//  ViewController.swift
//  StringFormatters
//
//  Created by Abhishek on 03/07/17.
//  Copyright © 2017 Nickelfox. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate  {

	var formatter = DateTextFormatter()
	
    override func viewDidLoad() {
        super.viewDidLoad()
        txtField.delegate = self
		formatter.seperaterType = .slash
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func validate(_ sender: Any) {
		
    }
    
    @IBOutlet weak var txtField: UITextField!

    @IBOutlet weak var dateLabel: UILabel!
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		let flag = formatter.textField(textField, replacementString: string)
		return flag
    }
}
