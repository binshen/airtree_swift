//
//  PersonController.swift
//  airtree_swift
//
//  Created by Bin Shen on 9/22/16.
//  Copyright © 2016 Bin Shen. All rights reserved.
//

import UIKit

class PersonController: UITableViewController {

    @IBOutlet var PersonTableView: UITableView!

    var timer: Timer!
    var avg_number: Float!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        UINavigationBar.appearance().tintColor = UIColor.white
        
        self.PersonTableView.delegate = self
        self.PersonTableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true);

//        let indexPath = IndexPath(row: 0, section: 0)
//        let cell = self.tableView.cellForRow(at: indexPath)
//        cell?.detailTextLabel?.text = _loginUser["nickname"] as! String

        self.autoRefreshData()
        self.timer = Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(autoRefreshData), userInfo: nil, repeats: true)
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
        let userID = _loginUser["_id"] as! String
        let url = MORAL_API_BASE_PATH + "/user/\(userID)/get_avg_data"
        let request = MKNetworkRequest(urlString: url, params: nil, bodyData: nil, httpMethod: "GET");
        request? .addCompletionHandler { response in
            let jsonStr = response?.responseAsString
            let data = jsonStr!.data(using: .utf8)!
            if let parsedData = try? JSONSerialization.jsonObject(with: data) as![String:Float] {
                self.avg_number = parsedData["avg"];
            }
            self.tableView.reloadData()
        }
        let engine = MKNetworkHost()
        engine.start(request)
    }

    override func prepare(`for` segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(`for`: segue, sender: sender)

        if segue.identifier == "SegueToLogout" {
            let userID = _loginUser?["_id"] as! String;
            let url = MORAL_API_BASE_PATH + "/user/\(userID)/offline"
            let request = MKNetworkRequest(urlString: url, params: nil, bodyData: nil, httpMethod: "POST");
            request? .addCompletionHandler { response in
                let jsonStr = response?.responseAsString
                print(jsonStr!)
            }
            let engine = MKNetworkHost()
            engine.start(request)

            var userDefaults = UserDefaults.standard
            userDefaults.setValue(nil, forKey: "user_id")

            _loginUser = nil
        }
    }


    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "PersonCell";
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
//        if(cell == nil) {
//            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
//        }
        switch indexPath.row {
            case 0:
                cell.textLabel?.text = "昵称"
                cell.detailTextLabel?.text = _loginUser["nickname"] as! String
            case 1:
                cell.textLabel?.text = "改密码"
                cell.detailTextLabel?.text = ""
            case 2:
                cell.textLabel?.text = "综合指数"
                cell.detailTextLabel?.text = self.avg_number == nil || self.avg_number == 0 ? "0" : "\(self.avg_number!)"
                cell.isUserInteractionEnabled = false;
                cell.accessoryType = UITableViewCellAccessoryType.none
            case 3:
                cell.textLabel?.text = "用户反馈"
                cell.detailTextLabel?.text = ""
            case 4:
                cell.textLabel?.text = ""
                cell.detailTextLabel?.text = ""
                cell.isUserInteractionEnabled = false;
                cell.accessoryType = UITableViewCellAccessoryType.none
            default:
                break
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        var viewController = self.storyboard!.instantiateViewController(withIdentifier: "PersonNicknameController")
        if(index == 1) {
            viewController = self.storyboard!.instantiateViewController(withIdentifier: "PersonPasswordController")
        } else if(index == 3) {
            viewController = self.storyboard!.instantiateViewController(withIdentifier: "PersonFeedbackController")
        } else {
            //TODO
        }
        self.navigationController?.pushViewController(viewController, animated: true)
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
