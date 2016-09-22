//
//  MainController.swift
//  airtree_swift
//
//  Created by Bin Shen on 9/22/16.
//  Copyright © 2016 Bin Shen. All rights reserved.
//

import UIKit

class MainController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var BtnDevice: UIButton!
    @IBOutlet weak var BtnOnlineShop: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var contentList = [Any]()
    var viewControllers = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        UINavigationBar.appearance().tintColor = UIColor.white

        self.navigationController!.navigationBar.barTintColor = UIColor(red: 20/255.0, green: 155/255.0, blue: 213/255.0, alpha: 1.0)
        self.navigationController!.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName: UIColor.white ]

        self.navigationItem.rightBarButtonItem = nil;


        print("-----------------------------------123")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);

        self.initHomePage()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initHomePage() {
        print("+++++++++++++++++++++++++++++++++++234")
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
