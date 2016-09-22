//
//  ViewController.swift
//  airtree_swift
//
//  Created by Bin Shen on 9/21/16.
//  Copyright © 2016 Bin Shen. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate, UIAlertViewDelegate {

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
        let username = TxtUsername.text!;
        let password = TxtPassword.text!;
        let baseURL = "http://api.7drlb.com";
        let params = ["username": username, "password": password]
        let request = MKNetworkRequest(urlString: baseURL + "/user/login", params: params, bodyData: nil, httpMethod: "POST");
        request? .addCompletionHandler { response in
            let jsonStr = response?.responseAsString
            var data = jsonStr!.data(using: .utf8)!
            if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                let user = parsedData["user"] as? [String:Any]
                if(user == nil) {
                    let alert: UIAlertView = UIAlertView(title: "登录失败", message: "输入的用户名或密码错误.", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                } else {
                    let nav = self.storyboard!.instantiateViewController(withIdentifier: "NavMainViewController")
                    self.present(nav, animated: true)
                }
            }
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

