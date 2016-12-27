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
    
    @IBOutlet weak var locationTextView: UITextView!
    var locationManager: CLLocationManager!
    var updateTimer: Timer?
    var current: Int = 0
    
    var viewA: BeaconView!
    var viewB: BeaconView!
    var viewC: BeaconView!
    var areaCoordinate: AreaCoordinate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        if updateTimer == nil {
            updateTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(doSomething), userInfo: nil, repeats: true)
        }
        
        view.backgroundColor = UIColor.gray
        
        let viewHeight = UIScreen.main.bounds.height / 4
        let viewWidth = UIScreen.main.bounds.width
        
        viewA = BeaconView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight), name: "A")
        self.view.addSubview(viewA)
        viewB = BeaconView(frame: CGRect(x: 0, y: viewHeight, width: viewWidth, height: viewHeight), name: "B")
        self.view.addSubview(viewB)
        viewC = BeaconView(frame: CGRect(x: 0, y: viewHeight * 2, width: viewWidth, height: viewHeight), name: "C")
        self.view.addSubview(viewC)
        areaCoordinate = AreaCoordinate()
        
    }
    
    func doSomething() {
        current += 1
        print("Hi! \(current)")
//        distanceReading.text = "\(current)"
        print("Background time remaining = \(UIApplication.shared.backgroundTimeRemaining) seconds")
    }
    
    func printLocation(areaCoordinate: [CLBeacon]) {
        
//        var nowAreaCoordinateUUIDs = [UUID]()
//        for beacon in nowAreaCoordinate {
//            nowAreaCoordinateUUIDs.append(beacon.proximityUUID)
//        }
//        print("now UUIDs list: " + String(describing: nowAreaCoordinateUUIDs))
        
//        var needUpdateNowAreaCoordinate = false
        
        // check is same area
//        for beacon in areaCoordinate {
            // have same beacon
//            if nowAreaCoordinateUUIDs.contains(beacon.proximityUUID) {
                // in same proximity
//                print("have same uuid")
//            } else {
//                print("have no same uuid")
//                needUpdateNowAreaCoordinate = true
//            }
//        }
        
//        if needUpdateNowAreaCoordinate {
            // update
//            nowAreaCoordinate = areaCoordinate
//        }
        
        
//        locationTextView.text.append("A : " +   + "\n")
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
        
        var newBeacons = [CLBeacon]()
        for beacon in beacons {
            if beacon.proximityUUID == UUID(uuidString: "74278BDA-B644-4520-8F0C-720EAF059935") {
                switch beacon.minor {
                case 0xFFE1:
                    viewA.updateBeaconData(proximity: beacon.proximity, distance: beacon.accuracy)
                    newBeacons.append(beacon)
                case 0xFFE2:
                    viewB.updateBeaconData(proximity: beacon.proximity, distance: beacon.accuracy)
                    newBeacons.append(beacon)
                default:
                    break
                }
            }
        }
        
        print("----------")
        print(current)
        print("new beacons : " + String(describing: newBeacons))
        print(areaCoordinate.checkIsSameCoordinate(newBeacons: newBeacons))
        areaCoordinate.updateAreaCoordinate(beacons: newBeacons)
        print(areaCoordinate.checkIsSameCoordinate(newBeacons: newBeacons))
        print("----------")
    }
}

