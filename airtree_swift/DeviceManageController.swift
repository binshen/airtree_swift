//
//  DeviceManageController.swift
//  airtree_swift
//
//  Created by Bin Shen on 9/22/16.
//  Copyright © 2016 Bin Shen. All rights reserved.
//

import UIKit

class DeviceManageController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        UINavigationBar.appearance().tintColor = UIColor.white

        self.tableView!.tableFooterView = UIView(frame: CGRect.zero)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        self.autoRefreshData()
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
            print(jsonStr)
            let data = jsonStr!.data(using: .utf8)!
//            if let parsedData = try? JSONSerialization.jsonObject(with: data) as! [String:Any] {
//                let user = parsedData["user"] as? [String:Any]
//                if(user == nil) {
//                    let alert: UIAlertView = UIAlertView(title: "登录失败", message: "输入的用户名或密码错误.", delegate: self, cancelButtonTitle: "OK")
//                    alert.show()
//                } else {
//                    let nav = self.storyboard!.instantiateViewController(withIdentifier: "NavMainViewController")
//                    self.present(nav, animated: true)
//                }
//                print(parsedData)
//            }
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
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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