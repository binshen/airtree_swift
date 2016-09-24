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
                let x9 = data?.value(forKey: "p9") as! Float
                if x9 == 0 {
                    self.main.text = "0"
                } else {
                    self.main.text = "\(x9)"
                }
                self.mainLable.text = "当前甲醛浓度（mg/m³）"
            } else if p1 == 4 {
                let x11 = data?.value(forKey: "p11")
                self.main.text = "\(x11)"
                self.mainLable.text = "当前温度（℃）"
            } else {
                let x3 = data?.value(forKey: "p3") as! Int
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
                self.mainImage.image = UIImage.animatedImageNamed("rank_1.gif", duration: 10)
            } else if feiLevel == 2 {
                self.airQuality.text = "良"
                self.mainImage.image = UIImage.animatedImageNamed("rank_2.gif", duration: 10)
            } else if feiLevel == 3 {
                self.airQuality.text = "中"
                self.mainImage.image = UIImage.animatedImageNamed("rank_3.gif", duration: 10)
            } else if feiLevel == 4 {
                self.airQuality.text = "差"
                self.mainImage.image = UIImage.animatedImageNamed("rank_4.gif", duration: 10)
            } else {
                self.airQuality.text = "未知"
            }
        } else {
            if pm25 <= 35 {
                self.airQuality.text = "优"
            } else if pm25 <= 75 {
                self.airQuality.text = "良"
            } else if pm25 <= 150 {
                self.airQuality.text = "中"
            } else {
                self.airQuality.text = "差"
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
