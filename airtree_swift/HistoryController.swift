//
//  HistoryController.swift
//  airtree_swift
//
//  Created by Bin Shen on 9/22/16.
//  Copyright © 2016 Bin Shen. All rights reserved.
//

import UIKit

class HistoryController: UIViewController {
    
    @IBOutlet weak var DateSelect: UIButton!
    @IBOutlet weak var LabelDescription: UILabel!
    @IBOutlet weak var mainValue: UILabel!
    @IBOutlet weak var pm25Value: UILabel!
    @IBOutlet weak var temperatureValue: UILabel!
    @IBOutlet weak var humidityValue: UILabel!
    @IBOutlet weak var formaldehydeValue: UILabel!
    @IBOutlet weak var pm25Label: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var formaldehydeLabel: UILabel!
    @IBOutlet weak var DividerLine: UIImageView!

    var pickerView: DateTimePicker!
    var selectedDate: NSDate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: Date())
        self.DateSelect.setTitle(dateString, for: UIControlState.normal)

        self.initView(date: Date())

        self.LabelDescription.layer.cornerRadius = 18
        self.LabelDescription.layer.masksToBounds = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if false {
            self.DateSelect.center = CGPoint(x: self.DateSelect.center.x, y: self.DateSelect.center.y - 20);
            self.mainValue.center = CGPoint(x: self.mainValue.center.x, y: self.mainValue.center.y - 50);
            self.LabelDescription.center = CGPoint(x: self.LabelDescription.center.x, y: self.LabelDescription.center.y + 40);
            self.DividerLine.center = CGPoint(x: self.DividerLine.center.x, y: self.DividerLine.center.y + 20);

            self.LabelDescription.font = UIFont.systemFont(ofSize: 15);

            self.pm25Value.font = UIFont.systemFont(ofSize: 14);
            self.pm25Label.font = UIFont.systemFont(ofSize: 14);
            self.temperatureValue.font = UIFont.systemFont(ofSize: 14);
            self.temperatureLabel.font = UIFont.systemFont(ofSize: 14);
            self.humidityValue.font = UIFont.systemFont(ofSize: 14);
            self.humidityLabel.font = UIFont.systemFont(ofSize: 14);
            self.formaldehydeValue.font = UIFont.systemFont(ofSize: 14);
            self.formaldehydeLabel.font = UIFont.systemFont(ofSize: 14);
        } else if false {
            self.mainValue.center = CGPoint(x: self.mainValue.center.x, y: self.mainValue.center.y - 15);
        } else if false {
            self.DateSelect.center = CGPoint(x: self.DateSelect.center.x, y: self.DateSelect.center.y + 25);
            self.mainValue.center = CGPoint(x: self.mainValue.center.x, y: self.mainValue.center.y + 30);
            self.LabelDescription.font = UIFont.systemFont(ofSize: 20)
        }

        let unit = UIScreen.main.bounds.size.width / 8
        self.pm25Value.center = CGPoint(x: unit, y: self.pm25Value.center.y);
        self.pm25Label.center = CGPoint(x: unit, y: self.pm25Label.center.y);

        self.temperatureValue.center = CGPoint(x: 3*unit, y: self.temperatureValue.center.y);
        self.temperatureLabel.center = CGPoint(x: 3*unit, y: self.temperatureLabel.center.y);

        self.humidityValue.center = CGPoint(x: 5*unit, y: self.humidityValue.center.y);
        self.humidityLabel.center = CGPoint(x: 5*unit, y: self.humidityLabel.center.y);

        self.formaldehydeValue.center = CGPoint(x: 7*unit, y: self.formaldehydeValue.center.y);
        self.formaldehydeLabel.center = CGPoint(x: 7*unit, y: self.formaldehydeLabel.center.y);
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView(date: Date) {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateString = dateFormatter.string(from: date)

        let device = _selectedDevice as? NSDictionary
        self.navigationItem.title = device?.value(forKey: "name") as? String == nil ? device?.value(forKey: "mac") as? String : device?.value(forKey: "name") as! String

        let mac = device?.value(forKey: "mac") as! String
        let url = MORAL_API_BASE_PATH + "/device/mac/\(mac)/get_history?day=\(dateString)"
        let request = MKNetworkRequest(urlString: url, params: nil, bodyData: nil, httpMethod: "GET");
        request?.addCompletionHandler { response in
            let jsonStr = response?.responseAsString
            let data = jsonStr!.data(using: .utf8)!
            if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                if parsedData.isEmpty {
                    
                } else {
                    if parsedData["x3"] as? Float == nil {
                        return
                    }

                    let x1 = parsedData["x1"] as! Float
                    let x3 = parsedData["x3"] as! Float
                    let x9 = parsedData["x9"] as! Float
                    let x10 = parsedData["x10"] as! Float
                    let x11 = parsedData["x11"] as! Float

                    self.mainValue.text = "\(Int(round(x3)))"
                    self.pm25Value.text = "\(round(x1))"
                    self.temperatureValue.text = "\(round(x11))"
                    self.humidityValue.text = "\(round(x10))"
                    self.humidityValue.text = "\(round(x9))"
                }
            }
        }
        let engine = MKNetworkHost()
        engine.start(request)
    }
    
    @IBAction func clickDateButton(_ sender: UIButton) {
        //self.pickerView.removeFromSuperview()

        let size = UIScreen.main.bounds.size
        let screenWidth = size.width
        let screenHeight = size.height

        if false {
            self.pickerView = DateTimePicker(frame: CGRect(x: 0, y: self.view.frame.size.height - 250, width: screenWidth, height: screenHeight / 2))
        } else {
            self.pickerView = DateTimePicker(frame: CGRect(x: 0, y: self.view.frame.size.height - 300, width: screenWidth, height: screenHeight / 2))
        }

        self.pickerView.addTarget(forDoneButton: self, action: #selector(donePressed))
        self.pickerView.addTarget(forCancelButton: self, action: #selector(cancelPressed))
        
        self.pickerView.isHidden = false
        self.pickerView.setMode(UIDatePickerMode.date)

        self.view.addSubview(self.pickerView)
    }

    func donePressed() {
        self.pickerView.isHidden = false
        self.pickerView.removeFromSuperview()

        self.initView(date: self.pickerView.picker.date)

        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateString = dateFormatter.string(from: self.pickerView.picker.date)
        self.DateSelect.setTitle(dateString, for: UIControlState.normal)
    }

    func cancelPressed() {
        self.pickerView.isHidden = true
        self.pickerView.removeFromSuperview()
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
