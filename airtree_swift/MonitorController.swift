//
//  MonitorController.swift
//  airtree_swift
//
//  Created by Bin Shen on 9/22/16.
//  Copyright © 2016 Bin Shen. All rights reserved.
//

import UIKit

class MonitorController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var ImgStatus: UIImageView!
    @IBOutlet weak var LabelStatus: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    var pageIndex: Int!
    var pageDevice: NSDictionary!
    
    var contentList = [AnyObject]()
    var viewControllers = [MonitorContentController?]()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.scrollView.isPagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        //self.scrollView.bounds = true
        self.scrollView.scrollsToTop = false
        //self.scrollView.autoresizingMask = true
        self.scrollView.delegate = self

        let rect = self.scrollView.frame

        var width = Global.screen_width()
        if Global.is_iphone6() || Global.is_iphone5() || Global.is_iphone_4_or_less() {
            width = Global.screen_width() + 8
        }

        self.scrollView.frame = CGRect(x: rect.origin.x, y: rect.origin.y, width: width, height: rect.size.height)
        self.scrollView.contentSize = CGSize(width: width * 4, height: 0)

        self.pageControl.hidesForSinglePage = true
        self.pageControl.isUserInteractionEnabled = false
        self.pageControl.transform = CGAffineTransform(scaleX:1.2, y:1.2)
        self.pageControl.numberOfPages = 4

        self.view.bringSubview(toFront: self.pageControl)

        var controllers = [MonitorContentController?]()
        for i in 0...3 {
            controllers.append(nil)
        }
        self.viewControllers = controllers
        self.pageControl.isHidden = false

        self.loadScrollViewWithPage(0)
        self.loadScrollViewWithPage(1)
        self.loadScrollViewWithPage(2)
        self.loadScrollViewWithPage(3)

        if self.pageIndex == 0 {
            self.navigationItem.title = "PM2.5"
        } else if self.pageIndex == 1 {
            self.navigationItem.title = "温度"
        } else if self.pageIndex == 2 {
            self.navigationItem.title = "湿度"
        } else {
            self.navigationItem.title = "甲醛"
        }

        self.scrollView.contentOffset = CGPoint(x: self.scrollView.frame.width, y: 0)
        self.pageControl.currentPage = self.pageIndex
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if Global.is_iphone_4_or_less() {
            self.ImgStatus.frame = CGRect(x: self.ImgStatus.frame.origin.x, y: self.ImgStatus.frame.origin.y - 5, width: self.ImgStatus.frame.size.width*0.7, height: self.ImgStatus.frame.size.height*0.7)

            self.LabelStatus.center = CGPoint(x: self.LabelStatus.center.x, y: self.LabelStatus.center.y - 25)
            self.LabelStatus.font = UIFont.systemFont(ofSize: 15)

            var heightConstraint: NSLayoutConstraint!
            for constraint in self.bottomView.constraints {
                if constraint.firstAttribute == NSLayoutAttribute.height {
                    heightConstraint = constraint
                    break
                }
            }
            heightConstraint.constant = 60;

        } else if Global.is_iphone5() {
            var frame = self.LabelStatus.frame
            frame.size.width = 220
            self.LabelStatus.frame = frame
        }
    }

    func loadScrollViewWithPage(_ page: Int) {
        if page >= 4 {
            return
        }

        var controller = self.viewControllers[page]
        if controller == nil {
            controller = self.storyboard?.instantiateViewController(withIdentifier: "MonitorContentController") as! MonitorContentController
            self.viewControllers[page] = controller
        }

        if controller?.view.superview == nil {
            var frame = self.scrollView.frame
            frame.origin.x = frame.width * CGFloat(page)
            frame.origin.y = 0
            controller?.view.frame = frame

            let data = self.pageDevice?.value(forKey: "p1") as! NSDictionary?
            let p1 = data?.value(forKey: "p1") as! Int
            if p1 > 0 {
                let feiLevel = data?.value(forKey: "fei") as! Int
                if feiLevel == 1 {
                    self.LabelStatus.text = "咱家空气棒棒哒，连呼吸都是甜的呢~"
                } else if feiLevel == 2 {
                    self.LabelStatus.text = "空气不错哦~只要再一丢丢的努力就完美啦~"
                } else if(feiLevel == 3) {
                    self.LabelStatus.text = "加把劲吧，咱家空气需要大大的改善~"
                } else {
                    self.LabelStatus.text = "你家的空气太糟糕啦，我要离家出走了~"
                }
            } else {
                let pm25 = data?.value(forKey: "x1") as! Int
                if pm25 <= 35 {
                    self.LabelStatus.text = "咱家空气棒棒哒，连呼吸都是甜的呢~"
                } else if pm25 <= 75 {
                    self.LabelStatus.text = "空气不错哦~只要再一丢丢的努力就完美啦~"
                } else if pm25 <= 150 {
                    self.LabelStatus.text = "加把劲吧，咱家空气需要大大的改善~"
                } else {
                    self.LabelStatus.text = "你家的空气太糟糕啦，我要离家出走了~"
                }
            }

            controller?.initViews(page, self.contentList[page] as! NSDictionary)
            self.scrollView.addSubview(controller!.view)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView!) {
        let pageWidth = self.scrollView.frame.width
        let page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
        self.pageControl.currentPage = Int(page);

        if page == 0 {
            self.navigationItem.title = "PM2.5"
        } else if page == 1 {
            self.navigationItem.title = "温度"
        } else if page == 2 {
            self.navigationItem.title = "温度"
        } else {
            self.navigationItem.title = "甲醛"
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
