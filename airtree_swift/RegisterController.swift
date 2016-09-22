//
//  RegisterController.swift
//  airtree_swift
//
//  Created by Bin Shen on 9/21/16.
//  Copyright © 2016 Bin Shen. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {

    @IBOutlet weak var BtnValidate: UIButton!
    @IBOutlet weak var BtnRegister: UIButton!
    
    @IBOutlet weak var TextTel: UITextField!
    @IBOutlet weak var TextCode: UITextField!
    @IBOutlet weak var TextPwd: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController!.setNavigationBarHidden(false, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func ClickBtnValidate(_ sender: UIButton) {
        print("++++++++++++++++1")
    }

    @IBAction func ClickBtnRegister(_ sender: UIButton) {
        print("----------------1")
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
