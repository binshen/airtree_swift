//
//  ForgetPwdController.swift
//  airtree_swift
//
//  Created by Bin Shen on 9/21/16.
//  Copyright © 2016 Bin Shen. All rights reserved.
//

import UIKit

class ForgetPwdController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var TextTel: UITextField!
    @IBOutlet weak var TextCode: UITextField!
    @IBOutlet weak var TextPwd: UITextField!
    @IBOutlet weak var BtnValidate: UIButton!

    var timer: Timer!
    var count: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController!.setNavigationBarHidden(false, animated: false)

        self.TextTel.delegate = self
        self.TextTel.keyboardType = UIKeyboardType.numberPad
        self.TextCode.delegate = self
        self.TextCode.keyboardType = UIKeyboardType.numberPad
        self.TextPwd.keyboardType = UIKeyboardType.alphabet
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)

        if self.timer != nil {
            self.timer.invalidate()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newLength = (textField.text?.characters.count)! - range.length + string.characters.count
        var length = 11
        if textField == self.TextCode {
            length = 6
        }
        return newLength > length ? false : true
    }

    @IBAction func ClickBtnValidate(_ sender: UIButton) {
        if !self.TextTel.hasText {
            let alert: UIAlertView = UIAlertView(title: "错误信息", message: "请输入手机号.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        } else {
            let userID = _loginUser["_id"] as! String
            let tel = self.TextTel.text!
            let params = ["tel": tel]
            let url = MORAL_API_BASE_PATH + "/user/request_code"
            let request = MKNetworkRequest(urlString: url, params: params, bodyData: nil, httpMethod: "POST");
            request? .addCompletionHandler { response in
                let jsonStr = response?.responseAsString
                let data = jsonStr!.data(using: .utf8)!
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let success = parsedData["success"] as? Bool
                    if success! {
                        self.count = 60
                        self.BtnValidate.setTitle("剩余60秒", for: UIControlState.normal)
                        self.BtnValidate.isEnabled = false
                        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.autoRefreshData), userInfo: nil, repeats: true)
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

    @IBAction func ClickBtnResetPwd(_ sender: UIButton) {
        if !self.TextTel.hasText {
            let alert: UIAlertView = UIAlertView(title: "错误信息", message: "请输入手机号.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        } else if !self.TextCode.hasText {
            let alert: UIAlertView = UIAlertView(title: "错误信息", message: "请输入验证码.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        } else if !self.TextPwd.hasText {
            let alert: UIAlertView = UIAlertView(title: "错误信息", message: "请输入密码.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        } else {
            let username = self.TextTel.text!
            let password = self.TextPwd.text!
            let code = self.TextCode.text!
            let tel = self.TextTel.text!
            let params = ["username": username, "password": password, "code": code]
            let url = MORAL_API_BASE_PATH + "/user/forget_psw"
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

    func autoRefreshData() {
        self.count = self.count - 1
        if self.count < 1 {
            self.BtnValidate.setTitle("获取验证码", for: UIControlState.normal)
            self.BtnValidate.isEnabled = true
        } else {
            self.BtnValidate.setTitle("剩余\(self.count!)秒", for: UIControlState.normal)
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
