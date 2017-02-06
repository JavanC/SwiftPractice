//
//  BeaconData.swift
//  DetectBeacon
//
//  Created by Javan.Chen on 2017/2/6.
//  Copyright © 2017年 Javan chen. All rights reserved.
//

import UIKit

class BeaconData : NSObject, NSCoding {
    var name: String!
    var uuid: UUID!
    var major: NSNumber!
    var minor: NSNumber!
    
    init(name: String, uuid: UUID, major: NSNumber, minor: NSNumber) {
        self.name = name
        self.uuid = uuid
        self.major = major
        self.minor = minor
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let uuid = aDecoder.decodeObject(forKey: "uuid") as! UUID
        let major = aDecoder.decodeObject(forKey: "major") as! NSNumber
        let minor = aDecoder.decodeObject(forKey: "minor") as! NSNumber
        self.init(name: name, uuid: uuid, major: major, minor: minor)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(uuid, forKey: "uuid")
        aCoder.encode(major, forKey: "major")
        aCoder.encode(minor, forKey: "minor")
    }
}
