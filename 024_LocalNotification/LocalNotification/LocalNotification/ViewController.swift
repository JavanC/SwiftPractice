//
//  ViewController.swift
//  LocalNotification
//
//  Created by javan.chen on 2015/11/18.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func registerLocal(sender: AnyObject) {
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
    }
    @IBAction func scheduleLocal(sender: AnyObject) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

