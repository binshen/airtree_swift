//
//  PersonNicknameController.swift
//  airtree_swift
//
//  Created by Bin Shen on 9/22/16.
//  Copyright © 2016 Bin Shen. All rights reserved.
//

import UIKit

class PersonNicknameController: UIViewController {

    @IBOutlet weak var TextNickname: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.TextNickname.text = _loginUser["nickname"] as! String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickUpdate(_ sender: UIButton) {
        let userID = _loginUser["_id"] as! String
        let nickname = self.TextNickname.text!
        let params = ["nickname": nickname]
        let url = MORAL_API_BASE_PATH + "/user/\(userID)/update_name"
        let request = MKNetworkRequest(urlString: url, params: params, bodyData: nil, httpMethod: "POST");
        request? .addCompletionHandler { response in
            let jsonStr = response?.responseAsString
            let data = jsonStr!.data(using: .utf8)!
            if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                let success = parsedData["success"] as? Bool
                if success! {
                    _loginUser["nickname"] = nickname
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
