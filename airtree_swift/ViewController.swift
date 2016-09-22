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

        let username = TxtUsername.text;
        let password = TxtPassword.text;

        print(username)
        print(password)

        let baseURL = "http://api.7drlb.com";
        let params = ["username": username, "password": password]
        let request = MKNetworkRequest(urlString: baseURL + "/user/login", params: params, bodyData: nil, httpMethod: "POST");
        request? .addCompletionHandler { response in
            print(response?.responseAsString)

        }
        let engine = MKNetworkHost()
        engine.start(request)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if ((textField.text?.characters.count)! - range.length + string.characters.count) > 11 {
            return false
        }
        return true
    }
}

