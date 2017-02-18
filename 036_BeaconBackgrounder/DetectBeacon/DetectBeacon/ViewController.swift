//
//  ViewController.swift
//  DetectBeacon
//
//  Created by javan.chen on 2015/11/20.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import UIKit
import CoreLocation

protocol BeaconViewControllerDelegate {
    func beaconsDataUpdate(beacons: [CLBeacon])
}

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var debugTextView: UITextView!

    var locationManager: CLLocationManager!
    var updateTimer: Timer?
    var current: Int = 0
    var delegate: BeaconViewControllerDelegate?
    
    var scanBeacons: [CLBeacon] = []
//    var nowBeaconArea: BeaconArea!
    
    @IBAction func actionAddBarButton(_ sender: UIBarButtonItem) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        
        if updateTimer == nil {
            updateTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(doSomething), userInfo: nil, repeats: true)
        }

        // Beacons Data
        BeaconsManager.sharedInstance.fetchBeacons()
        if BeaconsManager.sharedInstance.beacons.count == 0 {
            let beaconA = BeaconData(bleUUID: Config.A_UUID, name: "Javan's", uuid: Config.DEFAULT_UUID, major: 0x9712, minor: 0xFFE1)
            let beaconB = BeaconData(bleUUID: Config.B_UUID, name: "B", uuid: Config.DEFAULT_UUID, major: 0x9712, minor: 0x5566)
            let beaconC = BeaconData(bleUUID: Config.C_UUID, name: "C", uuid: Config.DEFAULT_UUID, major: 0x9712, minor: 0x5577)
            BeaconsManager.sharedInstance.beacons.append(beaconA)
            BeaconsManager.sharedInstance.beacons.append(beaconB)
            BeaconsManager.sharedInstance.beacons.append(beaconC)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        locationManager.delegate = self
    }
    
    func doSomething() {
        current += 1
//        print("Hi! \(current)")
//        print("Background time remaining = \(UIApplication.shared.backgroundTimeRemaining) seconds")
    }
    
    // MARK: - UITableView Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc : BeaconDetailViewController = mainStoryboard.instantiateViewController(withIdentifier: "BeaconDetailViewController") as! BeaconDetailViewController
        vc.beaconData = BeaconsManager.sharedInstance.beacons[indexPath.row]
        vc.beaconIndex = indexPath.row
        vc.vc = self
        self.show(vc, sender: nil)
    }
    
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
    
        // delegate
        self.delegate?.beaconsDataUpdate(beacons: beacons)
    }
}

