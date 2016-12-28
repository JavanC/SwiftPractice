//
//  AreaCoordinate.swift
//  DetectBeacon
//
//  Created by Javan.Chen on 2016/12/27.
//  Copyright © 2016年 Javan chen. All rights reserved.
//

import UIKit
import CoreLocation

class BeaconArea: NSObject {
    var name: String = ""
    var coordinate: [String: CLProximity] = [:]
    
    func updateAreaCoordinate(newBeacons: [CLBeacon]) {
        coordinate = [:]
        for newBeacon in newBeacons {
            coordinate[newBeacon.id()] = newBeacon.proximity
        }
    }
    
    func checkIsSameArea(newBeacons: [CLBeacon]) -> Bool {
        for newBeacon in newBeacons {
            if coordinate.keys.contains(newBeacon.id()) {
                if coordinate[newBeacon.id()] == newBeacon.proximity {
                    //print("same data.")
                } else {
                    //print("diffrent Proximity.")
                    return false
                }
            } else {
                //print("diffrent ID.")
                return false
            }
        }
        //print("all have same.")
        return true
    }
}
