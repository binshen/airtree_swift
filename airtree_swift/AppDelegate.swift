//
//  AppDelegate.swift
//  airtree_swift
//
//  Created by Bin Shen on 9/21/16.
//  Copyright © 2016 Bin Shen. All rights reserved.
//

import UIKit
import Foundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var _backgroundRunningTimeInterval: TimeInterval!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        Thread.sleep(forTimeInterval: 2.0)

        self._backgroundRunningTimeInterval = 0
        self.performSelector(inBackground: #selector(runningInBackground), with: nil)

        UITextField.appearance().tintColor = UIColor.black

        if UserDefaults.standard.value(forKey: "user_id") != nil && UserDefaults.standard.value(forKey: "user_id") != nil {
           _loginUser = [
                "_id": UserDefaults.standard.value(forKey: "user_id") as! String,
                "username": UserDefaults.standard.value(forKey: "username") as! String,
                "password": UserDefaults.standard.value(forKey: "password") as! String,
                "nickname": UserDefaults.standard.value(forKey: "nickname") as! String
           ]
           let nav = self.window?.rootViewController?.storyboard?.instantiateViewController(withIdentifier: "NavMainViewController")
           nav?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
           UINavigationBar.appearance().tintColor = UIColor.white

           self.window?.rootViewController = nav
           self.window?.makeKeyAndVisible()
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.

        if UIDevice.current.isMultitaskingSupported {
            BackgroundRunner.shared().run()
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.

        BackgroundRunner.shared().stop()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func runningInBackground() {
        while(true) {
            Thread.sleep(forTimeInterval: 10)
            _backgroundRunningTimeInterval = _backgroundRunningTimeInterval + 1
            print("Heartbeat: \(_backgroundRunningTimeInterval!)")
            self.runHeartbeatService()
        }
    }

    func runHeartbeatService() {
        if _loginUser?["_id"] == nil {
            return
        }
        let userID = _loginUser?["_id"] as! String;
        let url = MORAL_API_BASE_PATH + "/user/\(userID)/online"
        let request = MKNetworkRequest(urlString: url, params: nil, bodyData: nil, httpMethod: "POST");
        request? .addCompletionHandler { response in
            let jsonStr = response?.responseAsString
            print(jsonStr!)
        }
        let engine = MKNetworkHost()
        engine.start(request)
    }
}

