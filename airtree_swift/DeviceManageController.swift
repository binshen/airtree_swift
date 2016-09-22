//
//  DeviceManageController.swift
//  airtree_swift
//
//  Created by Bin Shen on 9/22/16.
//  Copyright © 2016 Bin Shen. All rights reserved.
//

import UIKit

class DeviceManageController: UITableViewController {

    var devices = [AnyObject]()
    var timer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        UINavigationBar.appearance().tintColor = UIColor.white

        self.tableView!.tableFooterView = UIView(frame: CGRect.zero)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true);
        
        self.autoRefreshData()
        self.timer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: Selector("autoRefreshData"), userInfo: nil, repeats: true)
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
        let baseURL = "http://api.7drlb.com"
        let userID = "5766a035f08504e7cd3fb33e"
        let request = MKNetworkRequest(urlString: baseURL + "/user/\(userID)/get_device_info", params: nil, bodyData: nil, httpMethod: "GET");
        request? .addCompletionHandler { response in
            let jsonStr = response?.responseAsString
            let data = jsonStr!.data(using: .utf8)!
            if let parsedData = try? JSONSerialization.jsonObject(with: data) as![AnyObject] {
                self.devices = parsedData
            }
            self.tableView.reloadData()
        }
        let engine = MKNetworkHost()
        engine.start(request)
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "addNewDevice" {
//            let reachability: Reachability = Reachability.reachabilityForInternetConnection()
//            let networkStatus: Int = reachability.currentReachabilityStatus().value
//            if(status != ReachableViaWiFi) {
//                let alert: UIAlertView = UIAlertView(title: "错误信息", message: "请先连接WIFI网络.", delegate: self, cancelButtonTitle: "OK")
//                alert.show()
//                return false
//            }
            let alert: UIAlertView = UIAlertView(title: "错误信息", message: "请先连接WIFI网络.", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            return false
        }
        return true
    }


    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.devices.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceMngCell", for: indexPath)
        let index = indexPath.row
        let device = self.devices[index] as? NSDictionary
        cell.textLabel?.text = device?.value(forKey: "name") as? String == nil ? device?.value(forKey: "mac") as? String : device?.value(forKey: "name") as! String
        cell.detailTextLabel?.text = device?["status"] as! Int == 1 ? "云端在线" : "不在线"
        return cell
    }

    override public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }


    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.separatorInset = UIEdgeInsets.zero
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("+++++++++++++++++++++++")
        print(self.devices[indexPath.row])
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
