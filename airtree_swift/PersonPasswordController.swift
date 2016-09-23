//
//  PersonPasswordController.swift
//  airtree_swift
//
//  Created by Bin Shen on 9/22/16.
//  Copyright © 2016 Bin Shen. All rights reserved.
//

import UIKit

class PersonPasswordController: UIViewController {
    
    @IBOutlet weak var PasswordOld: UITextField!
    @IBOutlet weak var PasswordNew: UITextField!
    @IBOutlet weak var PasswordReNew: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickUpdate(_ sender: UIButton) {
        if !self.PasswordOld.hasText {
            let alert: UIAlertView = UIAlertView(title: "错误信息", message: "请输入原密码.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        } else if !self.PasswordNew.hasText {
            let alert: UIAlertView = UIAlertView(title: "错误信息", message: "请输入新密码.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        } else if !self.PasswordReNew.hasText {
            let alert: UIAlertView = UIAlertView(title: "错误信息", message: "请输入确认密码.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        } else {
            let newPwd = self.PasswordNew.text!
            let reNewPwd = self.PasswordReNew.text!
            if newPwd != reNewPwd {
                let alert: UIAlertView = UIAlertView(title: "错误信息", message: "两次输入的新密码不一致.", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            } else {
                let oldPwd = self.PasswordOld.text!
                let userID = _loginUser["_id"] as! String
                let params = ["password": oldPwd, "new_password": newPwd]
                let url = MORAL_API_BASE_PATH + "/user/\(userID)/change_psw"
                let request = MKNetworkRequest(urlString: url, params: params, bodyData: nil, httpMethod: "POST");
                request? .addCompletionHandler { response in
                    let jsonStr = response?.responseAsString
                    let data = jsonStr!.data(using: .utf8)!
                    if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                        let success = parsedData["success"] as? Bool
                        if success! {
                            self.navigationController?.popViewController(animated: true)
                        } else {
                            let alert: UIAlertView = UIAlertView(title: "错误信息", message: parsedData["error"] as? String, delegate: self, cancelButtonTitle: "OK")
                            alert.show()
                        }
                    }
                }
                let engine = MKNetworkHost()
                engine.start(request)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
