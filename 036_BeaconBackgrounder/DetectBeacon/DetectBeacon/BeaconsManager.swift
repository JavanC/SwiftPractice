//
//  BeaconsManager.swift
//  DetectBeacon
//
//  Created by Javan.Chen on 2017/2/6.
//  Copyright © 2017年 Javan chen. All rights reserved.
//

import UIKit
import CoreLocation

class BeaconsManager: NSObject {
    static let sharedInstance = BeaconsManager()
    var coordinates: [BCoordinate] = []
    var beacons: [BeaconData] = []
    {
        didSet {
            saveBeaconsData()
            print("need save data")
        }
    }
    
    func fetchBeacons()
    {
        if let data = UserDefaults.standard.object(forKey: "beacons") as? Data {
            beacons = NSKeyedUnarchiver.unarchiveObject(with: data) as! [BeaconData]
        }
    }
    
    func saveBeaconsData()
    {
        let data = NSKeyedArchiver.archivedData(withRootObject: beacons)
        UserDefaults.standard.set(data, forKey: "beacons")
    }
    
    func updateCoordinate(newBeacons: [CLBeacon]) -> Bool {
        var coordinate:[Int] = []
        for beacon in beacons {
            if let newBeacon = newBeacons.filter({ $0.minor == beacon.minor }).first {
                coordinate.append(newBeacon.proximity.hashValue)
            } else {
                coordinate.append(0)
            }
        }
        
        if coordinates.count == 0 || coordinate != coordinates.first!.coordinate {
            coordinates.insert(BCoordinate(time: "time", coordinate: coordinate), at: 0)
            return true
        }
        return false
    }
}
