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
    
    @IBOutlet weak var distanceReading: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        view.backgroundColor = UIColor.grayColor()
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
                
//                self.distanceReading.text = "UNKNOWN\n\(mm)"
                
            case .Far:
                self.view.backgroundColor = UIColor.blueColor()
                self.distanceReading.text = String(format:"%.2f", mm)
//                self.distanceReading.text = "FAR\n\(mm)"
                
            case .Near:
                self.view.backgroundColor = UIColor.orangeColor()
                self.distanceReading.text = String(format:"%.2f", mm)
//                self.distanceReading.text = "NEAR\n\(mm)"
                
            case .Immediate:
                self.view.backgroundColor = UIColor.redColor()
                self.distanceReading.text = String(format:"%.2f", mm)
//                self.distanceReading.text = "RIGHT HERE\n\(mm)"
            }
        }
    }
    
    func locationManager(manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], inRegion region: CLBeaconRegion) {
        if beacons.count > 0 {
            let beacon = beacons[0]
//            print(beacon)
            
            updateDistance(beacon.proximity, mm: Double(beacon.rssi))
        } else {
            updateDistance(.Unknown, mm: 0)
        }
    }
}

