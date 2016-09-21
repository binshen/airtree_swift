//
//  ViewController.swift
//  airtree_swift
//
//  Created by Bin Shen on 9/21/16.
//  Copyright © 2016 Bin Shen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TxtUsername: UITextField!
    @IBOutlet weak var TxtPassword: UITextField!
    @IBOutlet weak var BtnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clickLoginButton(_ sender: UIButton) {
        print(TxtUsername.text)
    }
}

