//
//  ViewController.swift
//  DetectBeacon
//
//  Created by javan.chen on 2015/11/20.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var debugTextView: UITextView!

    var locationManager: CLLocationManager!
    var updateTimer: Timer?
    var current: Int = 0
    
    var scanBeacons: [CLBeacon] = []
//    var nowBeaconArea: BeaconArea!
    
    @IBAction func actionAddBarButton(_ sender: UIBarButtonItem) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        locationTextView.isEditable = false
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        if updateTimer == nil {
            updateTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(doSomething), userInfo: nil, repeats: true)
        }

        // Beacons Data
        BeaconsManager.sharedInstance.fetchBeacons()
        if BeaconsManager.sharedInstance.beacons.count == 0 {
            let beaconA = BeaconData(name: "A", uuid: Config.DEFAULT_UUID, major: 0xFFE1, minor: 0xFFE1)
            let beaconB = BeaconData(name: "B", uuid: Config.DEFAULT_UUID, major: 0xFFE1, minor: 0x5566)
            let beaconC = BeaconData(name: "C", uuid: Config.DEFAULT_UUID, major: 0xFFE1, minor: 0x5577)
            BeaconsManager.sharedInstance.beacons.append(beaconA)
            BeaconsManager.sharedInstance.beacons.append(beaconB)
            BeaconsManager.sharedInstance.beacons.append(beaconC)
        }
    }
    
    func doSomething() {
        current += 1
        print("Hi! \(current)")
        print("Background time remaining = \(UIApplication.shared.backgroundTimeRemaining) seconds")
    }
    
    // MARK: - UITableView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(BeaconsManager.sharedInstance.beacons.count)
        return BeaconsManager.sharedInstance.beacons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeaconTableViewCell", for: indexPath) as! BeaconTableViewCell
        let beacon = BeaconsManager.sharedInstance.beacons[indexPath.row]
        cell.mainTitleLabel.text = beacon.name
        cell.accessoryType = .disclosureIndicator
        
        if let scanBeacon = scanBeacons.filter({ $0.minor == beacon.minor }).first {
            cell.updateBeaconData(proximity: scanBeacon.proximity, distance: scanBeacon.accuracy)
        } else {
            cell.updateBeaconData(proximity: CLProximity.unknown, distance: 0)
        }
        
        return cell
    }
    
    // MARK: - UITableView Delegate
    
    
    // MARK: - CLLocationManager Delegate
    
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
        let beaconRegion = CLBeaconRegion(proximityUUID: Config.DEFAULT_UUID, identifier: "iBeacon")
        beaconRegion.notifyOnExit = true
        beaconRegion.notifyOnEntry = true
        
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        // update coordinate
        if BeaconsManager.sharedInstance.updateCoordinate(newBeacons: beacons) {
            debugTextView.text.removeAll()
            for bcoordinate in BeaconsManager.sharedInstance.coordinates {
                debugTextView.text.append(bcoordinate.time + " - " + String(describing: bcoordinate.coordinate!) + "\n")
            }
        }
        
        // update show beacon
        scanBeacons = beacons
        tableView.reloadData()
    
//        var newBeacons = [CLBeacon]()
        
//        scanBeacons = beacons.filter({  })
        
//        print(beacons.count)
//        for beacon in beacons {
//            print(beacon.proximityUUID)
//            if beacon.proximityUUID == UUID(uuidString: "74278BDA-B644-4520-8F0C-720EAF059935") {
//            if beacon.proximityUUID == UUID(uuidString: "AABBFFCC-5566-48D2-B060-D0F5A71096E0") {
//                switch beacon.minor {
//                case 0xFFE1:
//                    viewA.updateBeaconData(proximity: beacon.proximity, distance: beacon.accuracy)
//                    newBeacons.append(beacon)
//                case 0x5566:
//                    viewB.updateBeaconData(proximity: beacon.proximity, distance: beacon.accuracy)
//                    newBeacons.append(beacon)
//                case 0x5577:
//                    viewC.updateBeaconData(proximity: beacon.proximity, distance: beacon.accuracy)
//                    newBeacons.append(beacon)
//                default:
//                    break
//                }
//            }
//        }
//
//        // check is same area
//        if !nowBeaconArea.checkIsSameArea(newBeacons: newBeacons) {
//            // if diffrent, update now area
//            nowBeaconArea.updateAreaCoordinate(newBeacons: newBeacons)
//            print("Change Beacon Area")
//            // print to text view
//            var str = ""
//            for coordinate in nowBeaconArea.coordinate.enumerated() {
//                str += coordinate.element.key + " : " + String(describing: coordinate.element.value.hashValue) + ", "
//            }
//            locationTextView.text.append(str + "\n")
//        }
    }
}

