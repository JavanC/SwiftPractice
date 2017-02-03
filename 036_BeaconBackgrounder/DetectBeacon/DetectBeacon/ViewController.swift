//
//  ViewController.swift
//  DetectBeacon
//
//  Created by javan.chen on 2015/11/20.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var locationTextView: UITextView!

    var locationManager: CLLocationManager!
    var updateTimer: Timer?
    var current: Int = 0
    
//    var viewA: BeaconView!
//    var viewB: BeaconView!
//    var viewC: BeaconView!
//    var nowBeaconArea: BeaconArea!
    
    @IBAction func actionAddBarButton(_ sender: UIBarButtonItem) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        if updateTimer == nil {
            updateTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(doSomething), userInfo: nil, repeats: true)
        }
        
        
//        view.backgroundColor = UIColor.gray
    
//        let viewHeight = UIScreen.main.bounds.height / 4
//        let viewWidth = UIScreen.main.bounds.width
//        
//        viewA = BeaconView(frame: CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight), name: "A")
//        self.view.addSubview(viewA)
//        viewB = BeaconView(frame: CGRect(x: 0, y: viewHeight, width: viewWidth, height: viewHeight), name: "B")
//        self.view.addSubview(viewB)
//        viewC = BeaconView(frame: CGRect(x: 0, y: viewHeight * 2, width: viewWidth, height: viewHeight), name: "C")
//        self.view.addSubview(viewC)
//        nowBeaconArea = BeaconArea()
        
    }
//    
//    func getContext () -> NSManagedObjectContext {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        return appDelegate.persistentContainer.viewContext
//    }
//    
//    func addBeacon(name:String, uuid:String, major:String, minor:String) {
//        let context = getContext()
//        let beacon = NSEntityDescription.insertNewObject(forEntityName: "MyBeacon", into: self.)
//    }
    
    func doSomething() {
        current += 1
        print("Hi! \(current)")
        print("Background time remaining = \(UIApplication.shared.backgroundTimeRemaining) seconds")
    }
    
    
    // MARK: - UITableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeaconTableViewCell", for: indexPath) as! BeaconTableViewCell
        
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
//        let uuid = UUID(uuidString: "74278BDA-B644-4520-8F0C-720EAF059935")!
        let uuid = UUID(uuidString: "AABBFFCC-5566-48D2-B060-D0F5A71096E0")!
//        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: "MyBeacon")
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, identifier: "iBeacon")
        beaconRegion.notifyOnExit = true
        beaconRegion.notifyOnEntry = true
        
        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
//        var newBeacons = [CLBeacon]()
//        for beacon in beacons {
////            if beacon.proximityUUID == UUID(uuidString: "74278BDA-B644-4520-8F0C-720EAF059935") {
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

