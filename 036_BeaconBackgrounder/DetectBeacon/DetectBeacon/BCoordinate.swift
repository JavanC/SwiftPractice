//
//  BCoordinate.swift
//  DetectBeacon
//
//  Created by Javan.Chen on 2017/2/6.
//  Copyright © 2017年 Javan chen. All rights reserved.
//

import Foundation

class BCoordinate {
    var time: String!
    var coordinate: [Int]!
    
    init(time: String, coordinate: [Int]) {
        self.time = time
        self.coordinate = coordinate
    }
}
