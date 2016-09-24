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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    func initViews(initController controller: UIViewController, _ device: NSDictionary) {

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
