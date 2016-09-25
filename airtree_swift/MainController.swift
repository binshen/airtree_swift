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
    
    @IBOutlet weak var bottomView: UIView!
    
    var contentList = [AnyObject]()
    var viewControllers = [DeviceViewController?]()

    var timer: Timer!
    var numberPages: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        UINavigationBar.appearance().tintColor = UIColor.white

        self.navigationController!.navigationBar.barTintColor = UIColor(red: 20/255.0, green: 155/255.0, blue: 213/255.0, alpha: 1.0)
        self.navigationController!.navigationBar.titleTextAttributes = [ NSForegroundColorAttributeName: UIColor.white ]

        self.navigationItem.rightBarButtonItem = nil;

        self.scrollView.isPagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        //self.scrollView.bounds = true
        self.scrollView.scrollsToTop = false
        //self.scrollView.autoresizingMask = true
        self.scrollView.delegate = self

        var doubleTap = UITapGestureRecognizer(target: self, action: #selector(doDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.numberOfTouchesRequired = 1
        self.scrollView.addGestureRecognizer(doubleTap)

        self.pageControl.hidesForSinglePage = true
        self.pageControl.isUserInteractionEnabled = false
        self.pageControl.currentPage = 0
        self.pageControl.transform = CGAffineTransform(scaleX:1.2, y:1.2)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true);

        self.initHomePage()
        self.timer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(autoRefreshData), userInfo: nil, repeats: true)

        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if Global.is_iphone5() || Global.is_iphone_4_or_less() {
            var heightConstraint: NSLayoutConstraint!
            for constraint in self.bottomView.constraints {
                if constraint.firstAttribute == NSLayoutAttribute.height {
                    heightConstraint = constraint
                    break
                }
            }
            if Global.is_iphone5() {
                heightConstraint.constant = 80;
            } else {
                heightConstraint.constant = 60;
            }
        }
    }


    override func viewDidAppear(_ animated: Bool) {
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width * CGFloat(self.numberPages), height: self.scrollView.frame.size.height)
        super.viewDidAppear(animated)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initHomePage() {
        let userID = _loginUser["_id"] as! String
        let url = MORAL_API_BASE_PATH + "/user/\(userID)/get_device"
        let request = MKNetworkRequest(urlString: url, params: nil, bodyData: nil, httpMethod: "GET");
        request? .addCompletionHandler { response in
            let jsonStr = response?.responseAsString
            let data = jsonStr!.data(using: .utf8)!
            if let parsedData = try? JSONSerialization.jsonObject(with: data) as![AnyObject] {
                self.contentList = parsedData

                //self.scrollView.subviews
                self.numberPages = self.contentList.count

                var controllers = [DeviceViewController?]()
                for i in 0...self.numberPages {
                    controllers.append(nil)
                }
                self.viewControllers = controllers

                self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width * CGFloat(self.numberPages), height: self.scrollView.frame.size.height)

                self.pageControl.numberOfPages = self.numberPages
                self.pageControl.isHidden = false
                
                if self.pageControl.currentPage < 1 {
                    let device = self.contentList[0] as? NSDictionary
                    self.navigationItem.title = device?.value(forKey: "name") as? String == nil ? device?.value(forKey: "mac") as? String : device?.value(forKey: "name") as! String
                }

                for i in 0...self.numberPages {
                    self.loadScrollViewWithPage(i)
                }
            }

            self.spinner.stopAnimating()
        }
        self.spinner.transform = CGAffineTransform(scaleX:1.5, y:1.5)
        self.spinner.center = self.view.center
        self.spinner.startAnimating()

        let engine = MKNetworkHost()
        engine.start(request)
    }

    func loadScrollViewWithPage(_ page: Int) {
        if page >= self.contentList.count {
            return
        }

        var controller = self.viewControllers[page]
        if controller == nil {
            controller = self.storyboard?.instantiateViewController(withIdentifier: "DeviceViewController") as! DeviceViewController
            self.viewControllers[page] = controller
        }

        if controller?.view.superview == nil {
            var frame = self.scrollView.frame
            frame.origin.x = frame.width * CGFloat(page)
            frame.origin.y = 0
            controller?.view.frame = frame

            controller?.initViews(initController: self, self.contentList[page] as! NSDictionary)
            self.scrollView.addSubview(controller!.view)
        }
    }

    func autoRefreshData() {
        self.initHomePage()
    }

    func doDoubleTap(_ sender: UITapGestureRecognizer) {
        if sender.state == UIGestureRecognizerState.recognized {
            self.timer.invalidate()
            self.timer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(autoRefreshData), userInfo: nil, repeats: true)
            self.initHomePage()
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView!) {
        let pageWidth = self.scrollView.frame.width
        let page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
        self.pageControl.currentPage = Int(page);

        let device = self.contentList[Int(page)] as? NSDictionary
        if device?.value(forKey: "name") != nil {
            self.navigationItem.title = device?.value(forKey: "name") as! String
        } else if device?.value(forKey: "mac") != nil {
            self.navigationItem.title = device?.value(forKey: "mac") as! String
        } else {
            self.navigationItem.title = "房间"
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView!) {
        let pageWidth = self.scrollView.frame.width
        let page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
        // !!! but here is another problem. You should find reference to appropriate pageControl
        self.pageControl.currentPage = Int(page);
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
