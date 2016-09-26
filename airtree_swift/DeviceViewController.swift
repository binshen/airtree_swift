//
//  DeviceViewController.swift
//  airtree_swift
//
//  Created by Bin Shen on 9/22/16.
//  Copyright © 2016 Bin Shen. All rights reserved.
//

import UIKit

class DeviceViewController: UIViewController {
    
    @IBOutlet weak var electric: UIImageView!
    @IBOutlet weak var airQuality: UILabel!
    @IBOutlet weak var main: UILabel!
    @IBOutlet weak var mainLable: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var lightImage: UIImageView!
    @IBOutlet weak var suggest: UILabel!

    @IBOutlet weak var pm25Value: UILabel!
    @IBOutlet weak var temperatureValue: UILabel!
    @IBOutlet weak var humidityValue: UILabel!
    @IBOutlet weak var formaldehydeValue: UILabel!
    
    @IBOutlet weak var pm25Label: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var formalehydeLabel: UILabel!
    
    @IBOutlet weak var viewPm25: UIView!
    @IBOutlet weak var viewTemperature: UIView!
    @IBOutlet weak var viewHumidity: UIView!
    @IBOutlet weak var viewFormaldehyde: UIView!
    
    @IBOutlet weak var divider1: UIView!
    @IBOutlet weak var divider2: UIView!
    @IBOutlet weak var divider3: UIView!

    var pageDevice: NSDictionary!
    var parentController: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.viewPm25.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickPm25Tap)))
        self.viewTemperature.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickTemperatureTap)))
        self.viewHumidity.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickHumidityTap)))
        self.viewFormaldehyde.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(clickFormaldehydeTap)))
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let width = UIScreen.main.bounds.width
        self.divider1.frame = CGRect(x: width/4, y: 303, width: 1, height: 88)
        self.divider2.frame = CGRect(x: width/2, y: 303, width: 1, height: 88)
        self.divider3.frame = CGRect(x: width/4*3, y: 303, width: 1, height: 88)

        if Global.is_iphone6p() {
            self.mainImage.center = CGPoint(x: self.mainImage.center.x, y: self.mainImage.center.y + 15)
            self.lightImage.center = CGPoint(x: self.lightImage.center.x, y: self.lightImage.center.y + 15)

            self.airQuality.center = CGPoint(x: self.airQuality.center.x, y: self.airQuality.center.y + 15)
            self.main.center = CGPoint(x: self.main.center.x, y: self.main.center.y + 25)
            self.mainLable.center = CGPoint(x: self.mainLable.center.x, y: self.mainLable.center.y + 40)
            self.suggest.center = CGPoint(x: self.suggest.center.x, y: self.suggest.center.y + 80)

            self.divider1.center = CGPoint(x: self.divider1.center.x, y: self.divider1.center.y + 140)
            self.divider2.center = CGPoint(x: self.divider2.center.x, y: self.divider2.center.y + 140)
            self.divider3.center = CGPoint(x: self.divider3.center.x, y: self.divider3.center.y + 140)

            self.viewPm25.center = CGPoint(x: self.viewPm25.center.x - 25, y: self.viewPm25.center.y + 120)
            self.viewTemperature.center = CGPoint(x: self.viewTemperature.center.x - 8, y: self.viewTemperature.center.y + 120)
            self.viewHumidity.center = CGPoint(x: self.viewHumidity.center.x + 8, y: self.viewHumidity.center.y + 120)
            self.viewFormaldehyde.center = CGPoint(x: self.viewFormaldehyde.center.x + 25, y: self.viewFormaldehyde.center.y + 120)

            self.electric.frame = CGRect(x: self.electric.frame.origin.x + 103, y: self.electric.frame.origin.y + 10, width: self.electric.frame.size.width*0.5, height: self.electric.frame.size.height*0.5)
            self.mainImage.frame = CGRect(x: self.mainImage.frame.origin.x, y: self.mainImage.frame.origin.y, width: self.mainImage.frame.size.width*1.1, height: self.mainImage.frame.size.height*1.1)
            self.lightImage.frame = CGRect(x: self.lightImage.frame.origin.x - 15, y: self.lightImage.frame.origin.y - 10, width: self.lightImage.frame.size.width*1.3, height: self.lightImage.frame.size.height*1.3)

            self.airQuality.font = UIFont.systemFont(ofSize: 70)
            self.main.font = UIFont.systemFont(ofSize: 90)
            self.mainLable.font = UIFont.systemFont(ofSize: 18)
            self.suggest.font = UIFont.systemFont(ofSize: 18)

            self.pm25Label.font = UIFont.systemFont(ofSize: 18)
            self.temperatureLabel.font = UIFont.systemFont(ofSize: 18)
            self.humidityLabel.font = UIFont.systemFont(ofSize: 18)
            self.formalehydeLabel.font = UIFont.systemFont(ofSize: 18)
            self.pm25Value.font = UIFont.systemFont(ofSize: 17)
            self.temperatureValue.font = UIFont.systemFont(ofSize: 17)
            self.humidityValue.font = UIFont.systemFont(ofSize: 17)
            self.formaldehydeValue.font = UIFont.systemFont(ofSize: 17)
        } else if Global.is_iphone6() {
            self.mainImage.center = CGPoint(x: self.mainImage.center.x, y: self.mainImage.center.y + 10);
            self.lightImage.center = CGPoint(x: self.lightImage.center.x + 5, y: self.lightImage.center.y + 10);

            self.airQuality.center = CGPoint(x: self.airQuality.center.x, y: self.airQuality.center.y + 10);
            self.main.center = CGPoint(x: self.main.center.x, y: self.main.center.y + 15);
            self.mainLable.center = CGPoint(x: self.mainLable.center.x, y: self.mainLable.center.y + 30);
            self.suggest.center = CGPoint(x: self.suggest.center.x, y: self.suggest.center.y + 40);

            self.divider1.center = CGPoint(x: self.divider1.center.x, y: self.divider1.center.y + 70);
            self.divider2.center = CGPoint(x: self.divider2.center.x, y: self.divider2.center.y + 70);
            self.divider3.center = CGPoint(x: self.divider3.center.x, y: self.divider3.center.y + 70);

            self.viewPm25.center = CGPoint(x: self.viewPm25.center.x - 10, y: self.viewPm25.center.y + 50);
            self.viewTemperature.center = CGPoint(x: self.viewTemperature.center.x - 4, y: self.viewTemperature.center.y + 50);
            self.viewHumidity.center = CGPoint(x: self.viewHumidity.center.x, y: self.viewHumidity.center.y + 50);
            self.viewFormaldehyde.center = CGPoint(x: self.viewFormaldehyde.center.x + 5, y: self.viewFormaldehyde.center.y + 50);

            self.electric.frame = CGRect(x: self.electric.frame.origin.x + 118, y: self.electric.frame.origin.y + 10, width: self.electric.frame.size.width*0.4, height: self.electric.frame.size.height*0.4);
            self.lightImage.frame = CGRect(x: self.lightImage.frame.origin.x - 10, y: self.lightImage.frame.origin.y - 10, width: self.lightImage.frame.size.width*1.2, height: self.lightImage.frame.size.height*1.2);
        } else if Global.is_iphone5() {
            self.lightImage.center = CGPoint(x: self.lightImage.center.x, y: self.lightImage.center.y)

            self.airQuality.center = CGPoint(x: self.airQuality.center.x, y: self.airQuality.center.y - 15)
            self.main.center = CGPoint(x: self.main.center.x, y: self.main.center.y - 20)
            self.mainLable.center = CGPoint(x: self.mainLable.center.x, y: self.mainLable.center.y - 20)
            self.suggest.center = CGPoint(x: self.suggest.center.x, y: self.suggest.center.y - 20)

            self.divider1.center = CGPoint(x: self.divider1.center.x, y: self.divider1.center.y - 10)
            self.divider2.center = CGPoint(x: self.divider2.center.x, y: self.divider2.center.y - 10)
            self.divider3.center = CGPoint(x: self.divider3.center.x, y: self.divider3.center.y - 10)

            self.viewPm25.center = CGPoint(x: self.viewPm25.center.x + 10, y: self.viewPm25.center.y - 30)
            self.viewTemperature.center = CGPoint(x: self.viewTemperature.center.x, y: self.viewTemperature.center.y - 30)
            self.viewHumidity.center = CGPoint(x: self.viewHumidity.center.x - 10, y: self.viewHumidity.center.y - 30)
            self.viewFormaldehyde.center = CGPoint(x: self.viewFormaldehyde.center.x - 15, y: self.viewFormaldehyde.center.y - 30)

            self.electric.frame = CGRect(x: self.electric.frame.origin.x + 103, y: self.electric.frame.origin.y, width: self.electric.frame.width*0.4, height: self.electric.frame.height*0.4)
            self.mainImage.frame = CGRect(x: self.mainImage.frame.origin.x, y: self.mainImage.frame.origin.y, width: self.mainImage.frame.width*0.8, height: self.mainImage.frame.height*0.8)
            self.lightImage.frame = CGRect(x: self.lightImage.frame.origin.x, y: self.lightImage.frame.origin.y - 8, width: self.lightImage.frame.width, height: self.lightImage.frame.height)

            self.airQuality.font = UIFont(name: self.airQuality.font.familyName, size: self.airQuality.font.pointSize - 5)
            self.main.font = UIFont(name: self.main.font.familyName, size: self.main.font.pointSize - 10)

            self.pm25Label.font = UIFont.systemFont(ofSize: 13)
            self.temperatureLabel.font = UIFont.systemFont(ofSize: 13)
            self.humidityLabel.font = UIFont.systemFont(ofSize: 13)
            self.formalehydeLabel.font = UIFont.systemFont(ofSize: 13)
            self.pm25Value.font = UIFont.systemFont(ofSize: 12)
            self.temperatureValue.font = UIFont.systemFont(ofSize: 12)
            self.humidityValue.font = UIFont.systemFont(ofSize: 12)
            self.formaldehydeValue.font = UIFont.systemFont(ofSize: 12)
        } else {
            self.electric.center = CGPoint(x: self.electric.center.x + 40, y: self.electric.center.y - 8);
            self.mainImage.center = CGPoint(x: self.mainImage.center.x, y: self.mainImage.center.y - 10);
            self.lightImage.center = CGPoint(x: self.lightImage.center.x - 20, y: self.lightImage.center.y - 15);

            self.airQuality.center = CGPoint(x: self.airQuality.center.x, y: self.airQuality.center.y - 35);
            self.main.center = CGPoint(x: self.main.center.x, y: self.main.center.y - 50);
            self.mainLable.center = CGPoint(x: self.mainLable.center.x, y: self.mainLable.center.y - 50);
            self.suggest.center = CGPoint(x: self.suggest.center.x, y: self.suggest.center.y - 50);


            self.divider1.center = CGPoint(x: self.divider1.center.x, y: self.divider1.center.y - 60);
            self.divider2.center = CGPoint(x: self.divider2.center.x, y: self.divider2.center.y - 60);
            self.divider3.center = CGPoint(x: self.divider3.center.x, y: self.divider3.center.y - 60);

            self.viewPm25.center = CGPoint(x: self.viewPm25.center.x, y: self.viewPm25.center.y - 60);
            self.viewTemperature.center = CGPoint(x: self.viewTemperature.center.x, y: self.viewTemperature.center.y - 60);
            self.viewHumidity.center = CGPoint(x: self.viewHumidity.center.x, y: self.viewHumidity.center.y - 60);
            self.viewFormaldehyde.center = CGPoint(x: self.viewFormaldehyde.center.x, y: self.viewFormaldehyde.center.y - 60);


            self.electric.frame = CGRect(x: self.electric.frame.origin.x + 30, y: self.electric.frame.origin.y, width: self.electric.frame.size.width*0.6, height: self.electric.frame.size.height*0.6);
            self.mainImage.frame = CGRect(x: self.mainImage.frame.origin.x, y: self.mainImage.frame.origin.y, width: self.mainImage.frame.size.width*0.7, height: self.mainImage.frame.size.height*0.7);
            self.lightImage.frame = CGRect(x: self.lightImage.frame.origin.x, y: self.lightImage.frame.origin.y, width: self.lightImage.frame.size.width*0.7, height: self.lightImage.frame.size.height*0.7);

            self.airQuality.font = UIFont(name: self.airQuality.font.familyName, size: self.airQuality.font.pointSize - 10)
            self.main.font = UIFont(name: self.main.font.familyName, size: self.main.font.pointSize - 15)
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func clickPm25Tap() {
        if self.checkDeviceStatus() {
            return
        }
        self.parentController.navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        let monitor = self.storyboard?.instantiateViewController(withIdentifier: "MonitorController") as! MonitorController
        monitor.pageIndex = 0
        monitor.pageDevice = self.pageDevice
        self.parentController.navigationController?.pushViewController(monitor, animated: true)
    }

    func clickTemperatureTap() {
        if self.checkDeviceStatus() {
            return
        }
        self.parentController.navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        let monitor = self.storyboard?.instantiateViewController(withIdentifier: "MonitorController") as! MonitorController
        monitor.pageIndex = 1
        monitor.pageDevice = self.pageDevice
        self.parentController.navigationController?.pushViewController(monitor, animated: true)
    }

    func clickHumidityTap() {
        if self.checkDeviceStatus() {
            return
        }
        self.parentController.navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        let monitor = self.storyboard?.instantiateViewController(withIdentifier: "MonitorController") as! MonitorController
        monitor.pageIndex = 2
        monitor.pageDevice = self.pageDevice
        self.parentController.navigationController?.pushViewController(monitor, animated: true)
    }

    func clickFormaldehydeTap() {
        if self.checkDeviceStatus() {
            return
        }
        self.parentController.navigationController?.interactivePopGestureRecognizer?.isEnabled = false

        let monitor = self.storyboard?.instantiateViewController(withIdentifier: "MonitorController") as! MonitorController
        monitor.pageIndex = 3
        monitor.pageDevice = self.pageDevice
        self.parentController.navigationController?.pushViewController(monitor, animated: true)
    }

    func checkDeviceStatus() -> Bool {
        if self.pageDevice?.value(forKey: "status") as! Int != 1 {
            let alert: UIAlertView = UIAlertView(title: "错误信息", message: "请启动FEI环境数设备.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            return true
        } else {
            return false
        }
    }

    func initViews(initController controller: UIViewController, _ device: NSDictionary?) {
        self.pageDevice = device
        self.parentController = controller

        self.suggest.numberOfLines = 2

        let status = device?.value(forKey: "status") as! Int
        let data = device?.value(forKey: "data") as? NSDictionary
        if status == 1 {
            self.suggest.text = "云端在线"

            let type = device?.value(forKey: "type") as! Int
            if type == 1 {
                if data == nil || data?.value(forKey: "x13") == nil {
                    self.electric.image = UIImage(named: "ic_ele_n0s.png")
                } else {
                    self.electric.image = UIImage(named: "ic_ele_n\(data?.value(forKey: "x13") as! Int)s.png")
                }
            } else {
                self.electric.image = UIImage(named: "ic_ele_n4s.png")
            }
            self.electric.isHidden = false
        } else {
            if data == nil {
                self.suggest.text = ""
            } else {
                var dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let created = data?.value(forKey: "created") as! Double
                let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: created / 1000))
                self.suggest.text = "上次检测时间:\n\(dateString)"
            }
            self.electric.isHidden = true
        }

        if data == nil {
            self.pm25Value.text = "0ug/m³"
            self.temperatureValue.text = "0℃"
            self.humidityValue.text = "0%"
            self.formaldehydeValue.text = "0mg/m³"
            self.suggest.text = ""
            self.airQuality.text = "未知"
            return
        } else {
            let p1 = data?.value(forKey: "p1") as! Int
            if p1 == 3 {
                let x9 = data?.value(forKey: "x9") as! Float
                self.main.text = "\(x9)"
                self.mainLable.text = "当前甲醛浓度（mg/m³）"
            } else if p1 == 4 {
                let x11 = data?.value(forKey: "x11") as! Int
                self.main.text = "\(x11)"
                self.mainLable.text = "当前温度（℃）"
            } else {
                let x3 = data?.value(forKey: "x3") as! Int
                self.main.text = "\(x3)"
                self.mainLable.text = "0.3um颗粒物个数"
            }
        }

        let pm25 = data?.value(forKey: "x1") as! Float
        self.pm25Value.text = "\(pm25)ug/m³"
        self.temperatureValue.text = "\(data?.value(forKey: "x11") as! Float)℃"
        self.humidityValue.text = "\(data?.value(forKey: "x10") as! Float)%"
        self.formaldehydeValue.text = "\(data?.value(forKey: "x9") as! Float)mg/m³"

        let p1 = data?.value(forKey: "p1") as! Int
        if p1 > 0 {
            let feiLevel = data?.value(forKey: "fei") as! Int
            if feiLevel == 1 {
                self.airQuality.text = "优"
                self.mainImage.image = UIImage.animatedImage(withAnimatedGIFURL: Bundle.main.url(forResource: "rank_1", withExtension: "gif")!)
            } else if feiLevel == 2 {
                self.airQuality.text = "良"
                self.mainImage.image = UIImage.animatedImage(withAnimatedGIFURL: Bundle.main.url(forResource: "rank_2", withExtension: "gif")!)
            } else if feiLevel == 3 {
                self.airQuality.text = "中"
                self.mainImage.image = UIImage.animatedImage(withAnimatedGIFURL: Bundle.main.url(forResource: "rank_3", withExtension: "gif")!)
            } else if feiLevel == 4 {
                self.airQuality.text = "差"
                self.mainImage.image = UIImage.animatedImage(withAnimatedGIFURL: Bundle.main.url(forResource: "rank_4", withExtension: "gif")!)
            } else {
                self.airQuality.text = "未知"
            }
        } else {
            if pm25 <= 35 {
                self.airQuality.text = "优"
                self.mainImage.image = UIImage.animatedImage(withAnimatedGIFURL: Bundle.main.url(forResource: "rank_1", withExtension: "gif")!)
            } else if pm25 <= 75 {
                self.airQuality.text = "良"
                self.mainImage.image = UIImage.animatedImage(withAnimatedGIFURL: Bundle.main.url(forResource: "rank_2", withExtension: "gif")!)
            } else if pm25 <= 150 {
                self.airQuality.text = "中"
                self.mainImage.image = UIImage.animatedImage(withAnimatedGIFURL: Bundle.main.url(forResource: "rank_3", withExtension: "gif")!)
            } else {
                self.airQuality.text = "差"
                self.mainImage.image = UIImage.animatedImage(withAnimatedGIFURL: Bundle.main.url(forResource: "rank_4", withExtension: "gif")!)
            }
        }

        let x14 = data?.value(forKey: "x14") as! Int
        if x14 < 0 {
            return
        }
        if x14 > 500 {
            self.lightImage.image = UIImage.init(named: "light_01.png")
        } else if x14 < 240 {
            self.lightImage.image = UIImage.init(named: "light_03.png")
        } else {
            self.lightImage.image = UIImage.init(named: "light_02.png")
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
