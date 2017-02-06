//
//  CLBeacon_Ext.swift
//  DetectBeacon
//
//  Created by Javan.Chen on 2017/2/6.
//  Copyright © 2017年 Javan chen. All rights reserved.
//

import UIKit
import CoreLocation

extension CLBeacon {
    func id() -> String {
        //        return String(describing: self.major) + String(describing: self.minor)
        
        
        if self.minor == 0xFFE1 {
            return "A"
        } else if self.minor == 0x5566 {
            return "B"
        } else if self.minor == 0x5577 {
            return "C"
        } else {
            return String(describing: self.minor)
        }
    }
}
