//
//  MonitorContentController.swift
//  airtree_swift
//
//  Created by Bin Shen on 9/22/16.
//  Copyright © 2016 Bin Shen. All rights reserved.
//

import UIKit

class MonitorContentController: UIViewController {
    
    @IBOutlet weak var LabelCreatedTime: UILabel!
    @IBOutlet weak var ImgChart: UIImageView!
    @IBOutlet weak var LabelTop: UILabel!
    @IBOutlet weak var LabelMain: UILabel!
    @IBOutlet weak var LabelBottom: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()


    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initViews(_ page: Int, _ device: NSDictionary?) {
        let data = device?.value(forKey: "data") as! NSDictionary?
        if data == nil {
            self.LabelCreatedTime.text = "0000-00-00 00:00:00"
            self.LabelTop.text = ""
            self.LabelMain.text = "0"
            self.LabelBottom.text = ""
            self.ImgChart.image = UIImage.init(named: "bg_pm.png")
        } else {
            var dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let created = data?.value(forKey: "created") as! Double
            self.LabelCreatedTime.text = dateFormatter.string(from: Date(timeIntervalSince1970: created / 1000))

            if page == 0 {
                self.LabelTop.text = "PM2.5"
                self.LabelMain.text = "\(data?.value(forKey: "x1") as! Float)"
                self.LabelBottom.text = "ug/m³";
                self.ImgChart.image = UIImage.init(named: "bg_pm_s.png")
            } else if page == 0 {
                self.LabelTop.text = "温度"
                self.LabelMain.text = "\(data?.value(forKey: "x11") as! Float)"
                self.LabelBottom.text = "℃";
                self.ImgChart.image = UIImage.init(named: "bg_wendu_s.png")
            } else if page == 0 {
                self.LabelTop.text = "湿度"
                self.LabelMain.text = "\(data?.value(forKey: "x10") as! Float)"
                self.LabelBottom.text = "%";
                self.ImgChart.image = UIImage.init(named: "bg_shidu_s.png")
            } else {
                self.LabelTop.text = "甲醛"
                self.LabelMain.text = "\(data?.value(forKey: "x9") as! Float)"
                self.LabelBottom.text = "mg/m³";
                self.ImgChart.image = UIImage.init(named: "bg_jiaquan_s.png")
            }
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
