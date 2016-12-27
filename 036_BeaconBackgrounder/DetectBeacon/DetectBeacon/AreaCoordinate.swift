//
//  AreaCoordinate.swift
//  DetectBeacon
//
//  Created by Javan.Chen on 2016/12/27.
//  Copyright © 2016年 Javan chen. All rights reserved.
//

import UIKit
import CoreLocation


//class BeaconProximity: NSObject {
//    var proximityUUID: UUID
//    var proximity: CLProximity
//    init(proximityUUID: UUID, proximity: CLProximity) {
//        self.proximityUUID = proximityUUID
//        self.proximity = proximity
//    }
//}

class AreaCoordinate: NSObject {
    var coordinate: [String: CLProximity] = [:]
    
    func updateAreaCoordinate(beacons: [CLBeacon]) {
        coordinate = [:]
        for beacon in beacons {
            let id = String(describing: beacon.major)+String(describing: beacon.minor)
            coordinate[id] = beacon.proximity
        }
    }
    
    func checkIsSameCoordinate(newBeacons: [CLBeacon]) -> Bool {
//        print("-----")
//        print("coordinate: " + String(describing: coordinate))
//        print("new coordinate: " + String(describing: newBeacons))
        
        for beacon in newBeacons {
            let id = String(describing: beacon.major)+String(describing: beacon.minor)
            if coordinate.keys.contains(id) {
                if coordinate[id] == beacon.proximity {
                    print("same data.")
                } else {
                    print("diffrent Proximity.")
                    return false
                }
            } else {
                print("diffrent ID.")
                return false
            }
        }
        print("all have same.")
        return true
    }
}
