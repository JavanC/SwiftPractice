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
    var updateTimer: NSTimer?
    
    @IBOutlet weak var distanceReading: UILabel!
    
    
    @IBAction func didTapPlayPause(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected {
            updateTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(doSomething), userInfo: nil, repeats: true)
            // register background task
//            registerBackgroundTask()
        } else {
            updateTimer?.invalidate()
            updateTimer = nil
            // end background task
//            if backgroundTask != UIBackgroundTaskInvalid {
//                endBackgroundTask()
//            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        view.backgroundColor = UIColor.grayColor()
    }
    
    func doSomething() {
        print("Hi!")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedAlways {
            if CLLocationManager.isMonitoringAvailableForClass(CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    func startScanning() {
        let uuid = NSUUID(UUIDString: "74278BDA-B644-4520-8F0C-720EAF059935")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: "MyBeacon")
        beaconRegion.notifyOnExit = true
        beaconRegion.notifyOnEntry = true
//        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: "MyBeacon")
        
        locationManager.startMonitoringForRegion(beaconRegion)
        locationManager.startRangingBeaconsInRegion(beaconRegion)
    }
    
    func updateDistance(distance: CLProximity, mm: Double) {
        UIView.animateWithDuration(0.8) { [unowned self] in
            switch distance {
            case .Unknown:
                self.view.backgroundColor = UIColor.grayColor()
                self.distanceReading.text = String(format:"%.2f", mm)
                
            case .Far:
                self.view.backgroundColor = UIColor.blueColor()
                self.distanceReading.text = String(format:"%.2f", mm)

            case .Near:
                self.view.backgroundColor = UIColor.orangeColor()
                self.distanceReading.text = String(format:"%.2f", mm)
                
            case .Immediate:
                self.view.backgroundColor = UIColor.redColor()
                self.distanceReading.text = String(format:"%.2f", mm)
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        if beacons.count > 0 {
            let beacon = beacons[0]
            print(beacon.accuracy)
            
            updateDistance(beacon.proximity, mm: Double(beacon.rssi))
        } else {
            updateDistance(.Unknown, mm: 0)
        }
    }
    
//    func registerBackgroundTask() {
//        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
//            self?.endBackgroundTask()
//        }
//        assert(backgroundTask != UIBackgroundTaskInvalid)
//    }
//    
//    func endBackgroundTask() {
//        print("Background task ended.")
//        UIApplication.shared.endBackgroundTask(backgroundTask)
//        backgroundTask = UIBackgroundTaskInvalid
//    }
}

