//
//  ForgetPwdController.swift
//  airtree_swift
//
//  Created by Bin Shen on 9/21/16.
//  Copyright © 2016 Bin Shen. All rights reserved.
//

import UIKit

class ForgetPwdController: UIViewController {

    @IBOutlet weak var TextTel: UITextField!
    @IBOutlet weak var TextCode: UITextField!
    @IBOutlet weak var TextPwd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ClickBtnValidate(_ sender: UIButton) {
        print("++++++++++++++++++++2")
    }

    @IBAction func ClickBtnResetPwd(_ sender: UIButton) {
        
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
