////
////  DeviceAddController.swift
////  airtree_swift
////
////  Created by Bin Shen on 9/22/16.
////  Copyright © 2016 Bin Shen. All rights reserved.
////
//
//import UIKit
//import SystemConfiguration.CaptiveNetwork
//
//class DeviceAddController: UIViewController, UITextFieldDelegate {
//
//    @IBOutlet weak var txtSSID: UITextField!
//    @IBOutlet weak var txtPwd: UITextField!
//    @IBOutlet weak var butConnect: UIButton!
//    @IBOutlet weak var progress: UIProgressView!
//    @IBOutlet weak var switcher: UISwitch!
//
//    var smtlk: HFSmartLink!
//    var isconnecting: Bool!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        self.smtlk = HFSmartLink.shareInstence()
//        smtlk.isConfigOneDevice = true
//        smtlk.waitTimers = 30
//
//        self.isconnecting = false
//        self.progress.progress = 0.0
//        self.switcher.isOn = smtlk.isConfigOneDevice
//
//        self.showWifiSsid()
//        self.txtPwd.text = self.getspwdByssid(self.txtSSID.text!)
//        self.txtPwd.delegate = self
//        self.txtSSID.delegate = self
//    }
//
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(true)
//
//        smtlk.stop { (stopMsg: String?, isOk: Bool) in
//            self.isconnecting = false
//            self.setButTitle("开始连接")
//        }
//    }
//
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    @IBAction func butPressd(_ sender: UIButton) {
//        let ssidStr = self.txtSSID.text!
//        let pswdStr = self.txtPwd.text!
//
//        self.savePswd()
//        self.progress.progress = 0.0
//        if !isconnecting {
//            isconnecting = true
//            smtlk.start(withSSID: ssidStr, key: pswdStr, withV3x: true, processblock: { (pro: Int) in
//                    self.progress.progress = pro as! Float / 100.0
//                }, successBlock: { (dev: HFSmartLinkDeviceInfo) in
//                    let params = ["mac": dev.mac, "userID": _loginUser["_id"] as! String]
//                    let url = MORAL_API_BASE_PATH + "/user/add_device"
//                    let request = MKNetworkRequest(urlString: url, params: params, bodyData: nil, httpMethod: "POST");
//                    request? .addCompletionHandler { response in
//                        let jsonStr = response?.responseAsString
//                        let data = jsonStr!.data(using: .utf8)!
//                        if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
//                            let success = parsedData["success"] as? Bool
//                            if success! {
//                                if parsedData["status"] as? Int == 4 {
//                                    self.showAlertWithMsg("该设备已被其他人绑定过", "错误信息")
//                                } else {
//                                    self.navigationController?.popViewController(animated: true)
//                                }
//                            } else {
//                                self.showAlertWithMsg("输入的用户名或密码错误.", "错误信息")
//                            }
//                        }
//                    }
//                    let engine = MKNetworkHost()
//                    engine.start(request)
//                } as! SmartLinkSuccessBlock, fail: { (failmsg: String?) in
//                    self.setButTitle("开始连接")
//                    self.showAlertWithMsg("绑定时发生异常，请稍候再试", "错误信息")
//                }, end: { (deviceDic: NSDictionary) in
//                    self.isconnecting = false
//                    self.setButTitle("开始连接")
//                } as! SmartLinkEndblock
//            )
//            self.setButTitle("开始连接")
//        } else {
//            smtlk.stop { (stopMsg: String?, isOk: Bool) in
//                if isOk {
//                    self.isconnecting = false
//                    self.setButTitle("开始连接")
//                    self.showAlertWithMsg("配网模式已被终止", "确认信息")
//                } else {
//                    self.showAlertWithMsg("配网模式未能终止，请稍候再试", "错误信息")
//                }
//            }
//        }
//    }
//
//    @IBAction func swPressed(_ sender: UISwitch) {
//        if self.switcher.isOn {
//            self.smtlk.isConfigOneDevice = true
//        } else {
//            self.smtlk.isConfigOneDevice = false
//        }
//    }
//
//    func setButTitle(_ title: String) {
//        self.butConnect.setAttributedTitle(title as! NSAttributedString, for: UIControlState.normal)
//    }
//
//    func showAlertWithMsg(_ msg: String, _ title: String) {
//        let alert: UIAlertView = UIAlertView(title: title, message: msg, delegate: self, cancelButtonTitle: "OK")
//        alert.show()
//    }
//
//    func savePswd() {
//        var def = UserDefaults()
//        def.setValue(self.txtPwd.text!, forKey: self.txtSSID.text!)
//    }
//
//    func getspwdByssid(_ mssid: String) -> String? {
//        var def = UserDefaults()
//        return def.value(forKey: self.txtSSID.text!) as? String
//    }
//
//    func showWifiSsid() {
//        var wifiOK: Bool = false
//        if !wifiOK {
//            let ifs = self.fetchSSIDInfo()
//            let ssid = ifs?.value(forKey: "SSID") as? String
//            if ssid != nil {
//                wifiOK = true
//                self.txtSSID.text = ssid
//            } else {
//                let alert: UIAlertView = UIAlertView(title: "错误信息", message: "请连接Wi-Fi", delegate: self, cancelButtonTitle: "OK")
//                alert.show()
//            }
//        }
//    }
//
//    func fetchSSIDInfo() -> NSDictionary? {
//        if let interfaces = CNCopySupportedInterfaces() {
//            for i in 0..<CFArrayGetCount(interfaces) {
//                let interfaceName: UnsafeRawPointer = CFArrayGetValueAtIndex(interfaces, i)
//                let rec = unsafeBitCast(interfaceName, to: AnyObject.self)
//                return CNCopyCurrentNetworkInfo("\(rec)" as CFString) as! NSDictionary
//            }
//        }
//        return nil
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
