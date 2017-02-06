//
//  AppDelegate.swift
//  DetectBeacon
//
//  Created by javan.chen on 2015/11/20.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let locationManager = CLLocationManager()
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let notificationType:UIUserNotificationType = [UIUserNotificationType.sound, UIUserNotificationType.alert]
        let notificationSettings = UIUserNotificationSettings(types: notificationType, categories: nil)
        UIApplication.shared.registerUserNotificationSettings(notificationSettings)
        locationManager.delegate = self
        
        reinstateBackgroundTask()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        UserDefaults.standard.synchronize()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("open app, did become active")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("2222")
        if region is CLBeaconRegion {
            print("test exit!!")
            let notification = UILocalNotification()
            notification.alertBody = "Exit region"
            notification.soundName = "Default"
            UIApplication.shared.presentLocalNotificationNow(notification)
            
            reinstateBackgroundTask()
            print("register bg task")
        }
    }
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("1111")
        if region is CLBeaconRegion {
            print("test enter!!")
            let notification = UILocalNotification()
            notification.alertBody = "Enter region"
            notification.soundName = "Default"
            UIApplication.shared.presentLocalNotificationNow(notification)
        
            reinstateBackgroundTask()
            print("register bg task")
        }
    }
    
    func reinstateBackgroundTask() {
        print("Background task reinstate.")
        if backgroundTask == UIBackgroundTaskInvalid {
            registerBackgroundTask()
        }
    }
    func registerBackgroundTask() {
        print("Background task register.")
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.endBackgroundTask()
        }
        assert(backgroundTask != UIBackgroundTaskInvalid)
    }
    func endBackgroundTask() {
        print("Background task ended.")
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = UIBackgroundTaskInvalid
    }
}
