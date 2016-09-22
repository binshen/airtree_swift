//
//  ShopController.swift
//  airtree_swift
//
//  Created by Bin Shen on 9/22/16.
//  Copyright © 2016 Bin Shen. All rights reserved.
//

import UIKit

class ShopController: UIViewController {
    
    @IBOutlet weak var WebView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.WebView.isOpaque = false
        self.WebView.backgroundColor = UIColor.clear
        self.WebView.scalesPageToFit = true
        self.view!.addSubview(self.WebView)
        
        let url: NSURL = NSURL(string: "http://moral.tmall.com")!
        self.WebView.loadRequest(NSURLRequest(url: url as URL) as URLRequest)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
