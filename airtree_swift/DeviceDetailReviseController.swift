//
//  DeviceDetailReviseController.swift
//  airtree_swift
//
//  Created by Bin Shen on 9/22/16.
//  Copyright © 2016 Bin Shen. All rights reserved.
//

import UIKit

class DeviceDetailReviseController: UIViewController {
    
    @IBOutlet weak var TextDeviceName: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        let device = _selectedDevice as? NSDictionary
        if device?.value(forKey: "name") != nil {
            self.TextDeviceName.text = device?.value(forKey: "name") as! String
        } else {
            self.TextDeviceName.text = device?.value(forKey: "mac") as! String
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickUpdate(_ sender: UIButton) {
        if !self.TextDeviceName.hasText {
            let alert: UIAlertView = UIAlertView(title: "错误信息", message: "请输入设备名称.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
        } else {
            let userID = _loginUser["_id"] as! String
            let device = _selectedDevice as? NSDictionary
            let deviceID = device!.value(forKey: "_id") as! String
            let deviceName = self.TextDeviceName.text!
            let params = ["name": deviceName]
            let url = MORAL_API_BASE_PATH + "/user/\(userID)/device/\(deviceID)/update_name"
            let request = MKNetworkRequest(urlString: url, params: params, bodyData: nil, httpMethod: "POST");
            request? .addCompletionHandler { response in
                let jsonStr = response?.responseAsString
                let data = jsonStr!.data(using: .utf8)!
                if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                    let success = parsedData["success"] as? Bool
                    if success! {
                        //_selectedDevice.set(deviceName, forKey: "name")
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
