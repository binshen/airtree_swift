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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        UINavigationBar.appearance().tintColor = UIColor.white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true);

        let indexPath = IndexPath(row: 1, section: 0)
        let cell = self.tableView.cellForRow(at: indexPath)
        cell?.detailTextLabel?.text = "12312321"

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

    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeviceInfoCell", for: indexPath)
        switch indexPath.row {
            case 0:
                cell.textLabel?.text = "设备编码"
            case 1:
                cell.textLabel?.text = "设备名称"
            case 2:
                cell.textLabel?.text = "类型"
            case 3:
                cell.textLabel?.text = "MAC"
            case 4:
                cell.textLabel?.text = "历史数据"
            case 5:
                cell.textLabel?.text = "滤网检测"
            case 6:
                cell.textLabel?.text = ""
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
