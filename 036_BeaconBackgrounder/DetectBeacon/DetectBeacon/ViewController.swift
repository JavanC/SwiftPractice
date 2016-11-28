//
//  ViewController.swift
//  DetectBeacon
//
//  Created by javan.chen on 2015/11/20.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    var locationManager: CLLocationManager!
    var updateTimer: Timer?
    var current: Int = 0
    
    deinit {
        print("deinit app")
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBOutlet weak var distanceReading: UILabel!
    
    
    @IBAction func didTapPlayPause(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            updateTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(doSomething), userInfo: nil, repeats: true)
            // register background task
            registerBackgroundTask()
        } else {
            updateTimer?.invalidate()
            updateTimer = nil
            // end background task
            if backgroundTask != UIBackgroundTaskInvalid {
                endBackgroundTask()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        NotificationCenter.default.addObserver(self, selector: #selector(reinstateBackgroundTask), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        view.backgroundColor = UIColor.gray
        
    }
    
    func doSomething() {
        current += 1
        print("Hi! \(current)")
        distanceReading.text = "\(current)"
        print("Background time remaining = \(UIApplication.shared.backgroundTimeRemaining) seconds")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        let uuid = UUID(uuidString: "74278BDA-B644-4520-8F0C-720EAF059935")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: "MyBeacon")
        beaconRegion.notifyOnExit = true
        beaconRegion.notifyOnEntry = true
//        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: "MyBeacon")
        
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }
    
    func updateDistance(_ distance: CLProximity, mm: Double) {
        UIView.animate(withDuration: 0.8, animations: { [unowned self] in
            switch distance {
            case .unknown:
                self.view.backgroundColor = UIColor.gray
//                self.distanceReading.text = String(format:"%.2f", mm)
                
            case .far:
                self.view.backgroundColor = UIColor.blue
//                self.distanceReading.text = String(format:"%.2f", mm)

            case .near:
                self.view.backgroundColor = UIColor.orange
//                self.distanceReading.text = String(format:"%.2f", mm)
                
            case .immediate:
                self.view.backgroundColor = UIColor.red
//                self.distanceReading.text = String(format:"%.2f", mm)
            }
        }) 
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if beacons.count > 0 {
            let beacon = beacons[0]
            print(beacon.accuracy)
            
            updateDistance(beacon.proximity, mm: Double(beacon.rssi))
        } else {
            updateDistance(.unknown, mm: 0)
        }
    }
    
    func reinstateBackgroundTask() {
        print("Background task reinstate.")
        if updateTimer != nil && (backgroundTask == UIBackgroundTaskInvalid) {
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

