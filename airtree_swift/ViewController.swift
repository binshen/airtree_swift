//
//  ViewController.swift
//  airtree_swift
//
//  Created by Bin Shen on 9/21/16.
//  Copyright © 2016 Bin Shen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var TxtUsername: UITextField!
    @IBOutlet weak var TxtPassword: UITextField!
    @IBOutlet weak var BtnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        TxtUsername.delegate = self
        TxtUsername.keyboardType = UIKeyboardType.numberPad
        TxtPassword.keyboardType = UIKeyboardType.alphabet
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clickLoginButton(_ sender: UIButton) {
        print(TxtUsername.text)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if ((textField.text?.characters.count)! - range.length + string.characters.count) > 11 {
            return false
        }
        return true
    }
}

