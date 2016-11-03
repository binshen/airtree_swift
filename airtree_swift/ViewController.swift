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

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        UINavigationBar.appearance().tintColor = UIColor.white

        self.navigationController!.navigationBar.barTintColor = UIColor(red: 20/255.0, green: 155/255.0, blue: 213/255.0, alpha: 1.0)
        self.navigationController!.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName: UIColor.white ]

        TxtUsername.delegate = self
        TxtUsername.keyboardType = UIKeyboardType.numberPad
        TxtPassword.keyboardType = UIKeyboardType.alphabet

        //TxtUsername.text = "13999999999"
        //TxtPassword.text = "888888"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);

        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clickLoginButton(_ sender: UIButton) {
        let username = TxtUsername.text!
        let password = TxtPassword.text!
        let params = ["username": username, "password": password]
        let url = MORAL_API_BASE_PATH + "/user/login"
        let request = MKNetworkRequest(urlString: url, params: params, bodyData: nil, httpMethod: "POST");
        request? .addCompletionHandler { response in
            let jsonStr = response?.responseAsString
            let data = jsonStr!.data(using: .utf8)!
            if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                let userDefaults = UserDefaults.standard
                let user = parsedData["user"] as? [String:Any]
                if(user == nil) {
                    userDefaults.setValue(nil, forKey: "user_id")

                    let alert: UIAlertView = UIAlertView(title: "登录失败", message: "输入的用户名或密码错误.", delegate: self, cancelButtonTitle: "OK")
                    alert.show()
                } else {
                    _loginUser = user

                    userDefaults.setValue(_loginUser["_id"] as! String, forKey: "user_id")
                    userDefaults.setValue(_loginUser["username"] as! String, forKey: "username")
                    userDefaults.setValue(_loginUser["password"] as! String, forKey: "password")
                    userDefaults.setValue(_loginUser["nickname"] as! String, forKey: "nickname")
                    userDefaults.synchronize()

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

