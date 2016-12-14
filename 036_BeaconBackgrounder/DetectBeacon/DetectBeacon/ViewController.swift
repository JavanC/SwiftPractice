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
    
    var locationManager: CLLocationManager!
    var updateTimer: Timer?
    var current: Int = 0
    
    var viewA: BeaconView!
    var viewB: BeaconView!
    
    @IBAction func didTapPlayPause(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            updateTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(doSomething), userInfo: nil, repeats: true)
        } else {
            updateTimer?.invalidate()
            updateTimer = nil
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        view.backgroundColor = UIColor.gray
        
        let viewHeight = UIScreen.main.bounds.height / 4
        let viewWidth = UIScreen.main.bounds.width
        
        viewA = BeaconView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight), name: "A")
        self.view.addSubview(viewA)
        
    }
    
    func doSomething() {
        current += 1
        print("Hi! \(current)")
//        distanceReading.text = "\(current)"
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
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if beacons.count > 0 {
            let beacon = beacons[0]
            print(beacon.accuracy)
            print(beacon.proximityUUID)
            print("Background time remaining = \(UIApplication.shared.backgroundTimeRemaining) seconds")
            viewA.updateBeaconData(proximity: beacon.proximity, distance: beacon.accuracy)
        } else {
//            updateDistance(.unknown, mm: 0)
        }
    }
}

