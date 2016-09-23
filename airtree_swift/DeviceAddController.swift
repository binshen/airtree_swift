//
//  DeviceAddController.swift
//  airtree_swift
//
//  Created by Bin Shen on 9/22/16.
//  Copyright © 2016 Bin Shen. All rights reserved.
//

import UIKit

class DeviceAddController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var txtSSID: UITextField!
    @IBOutlet weak var txtPwd: UITextField!
    @IBOutlet weak var butConnect: UIButton!
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var switcher: UISwitch!

//    var smtlk: HFSmartLink!
//    var isconnecting: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.smtlk = HFSmartLink.shareInstence()
//        smtlk.isConfigOneDevice = true
//        smtlk.waitTimers = 30
//
//        self.isconnecting = false
//        self.progress.progress = 0.0
//        self.switcher.isOn = smtlk.isConfigOneDevice
//
//        self.showWifiSsid()
//        self.txtPwd.delegate = self
//        self.txtSSID.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    func showWifiSsid() {

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
