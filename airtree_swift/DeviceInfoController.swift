//
//  DeviceInfoController.swift
//  airtree_swift
//
//  Created by Bin Shen on 9/22/16.
//  Copyright © 2016 Bin Shen. All rights reserved.
//

import UIKit

class DeviceInfoController: UITableViewController, UIAlertViewDelegate {

    @IBOutlet weak var bottomView: UIView!
    
    var timer: Timer!
    var checkStatus: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        UINavigationBar.appearance().tintColor = UIColor.white

        let device = _selectedDevice as? NSDictionary
        let type = device?.value(forKey: "type") as? Int
        if type == 1 {
            self.autoRefreshData()
        }

        if false {
            var frame = self.bottomView.frame
            frame.size.height = 60
            self.bottomView.frame = frame
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true);

        let device = _selectedDevice as? NSDictionary
        let indexPath = IndexPath(row: 1, section: 0)
        let cell = self.tableView.cellForRow(at: indexPath)
        cell?.detailTextLabel?.text = device?.value(forKey: "name") as? String

        self.timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(autoRefreshData), userInfo: nil, repeats: true)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)

        self.timer.invalidate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func autoRefreshData() {
        let device = _selectedDevice as? NSDictionary
        let mac = device?.value(forKey: "mac") as! String
        let request = MKNetworkRequest(urlString: MORAL_API_BASE_PATH + "/device/mac/\(mac)/get_test", params: nil, bodyData: nil, httpMethod: "GET");
        request? .addCompletionHandler { response in
            let jsonStr = response?.responseAsString
            let data = jsonStr!.data(using: .utf8)!
            if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
                let test = parsedData["test"] as? Int
                if test != nil {
                    var dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let created = parsedData["created"] as! Double
                    let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: created / 1000))
                    self.checkStatus = test == 1 ? "需要更换(\(dateString))" : "无需更换(\(dateString))"
                } else {
                    self.checkStatus = ""
                }
            }

            let indexPath = IndexPath(row: 5, section: 0)
            let cell = self.tableView.cellForRow(at: indexPath)
            cell?.detailTextLabel?.text = self.checkStatus
            if false {
                cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 15)
            } else if false {
                cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 14)
            }
        }
        let engine = MKNetworkHost()
        engine.start(request)
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let device = _selectedDevice as? NSDictionary
        let type = device?.value(forKey: "type") as? Int
        if type == 1 {
            return 7
        } else {
            return 6
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let device = _selectedDevice as? NSDictionary
        let type = device?.value(forKey: "type") as? Int
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceInfoCell", for: indexPath)
        cell.isUserInteractionEnabled = false
        cell.accessoryType = UITableViewCellAccessoryType.none
        switch indexPath.row {
            case 0:
                cell.textLabel?.text = "设备编码"
                cell.detailTextLabel?.text = device?.value(forKey: "_id") as? String
                if false { //TODO
                    cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 15)
                }
            case 1:
                cell.textLabel?.text = "设备名称"
                cell.detailTextLabel?.text = device?.value(forKey: "name") as? String == nil ? device?.value(forKey: "mac") as? String : device?.value(forKey: "name") as! String
                cell.isUserInteractionEnabled = true
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            case 2:
                cell.textLabel?.text = "类型"
                cell.detailTextLabel?.text = device?.value(forKey: "status") as? Int == 1 ? "主机" : "从机"
            case 3:
                cell.textLabel?.text = "MAC"
                cell.detailTextLabel?.text = device?.value(forKey: "mac") as? String
            case 4:
                cell.textLabel?.text = "历史数据"
                cell.detailTextLabel?.text = ""
                cell.isUserInteractionEnabled = true
                cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
            case 5:
                if type == 1 {
                    cell.textLabel?.text = "滤网检测"
                } else {
                    cell.textLabel?.text = ""
                    cell.detailTextLabel?.text = ""
                }
            case 6:
                cell.textLabel?.text = ""
                cell.detailTextLabel?.text = ""
            default:
                break
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        if(index == 1) {
            let viewController = self.storyboard!.instantiateViewController(withIdentifier: "DeviceDetailReviseController")
            self.navigationController?.pushViewController(viewController, animated: true)
        } else if(index == 4) {
            let viewController = self.storyboard!.instantiateViewController(withIdentifier: "HistoryController")
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }

    override public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var device = _selectedDevice as? NSDictionary
        let type = device?.value(forKey: "type") as? Int
        if type == 1 {
            if indexPath.row == 6 {
                return 0
            }
        } else {
            if indexPath.row == 5 {
                return 0
            }
        }
        return 60
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
