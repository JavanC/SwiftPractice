//
//  NSData_Ext.swift
//  DetectBeacon
//
//  Created by Javan.Chen on 2017/2/13.
//  Copyright © 2017年 Javan chen. All rights reserved.
//

import Foundation

extension NSData {
    func getByteArray() -> [UInt8]? {
        var byteArray: [UInt8] = [UInt8]()
        for i in 0..<self.length {
            var temp: UInt8 = 0
            self.getBytes(&temp, range: NSRange(location: i, length: 1))
            byteArray.append(temp)
        }
        return byteArray
    }
}
