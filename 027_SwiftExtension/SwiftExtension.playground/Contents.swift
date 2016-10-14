//: Playground - noun: a place where people can play

import UIKit

extension Int {
    mutating func plusOne() {
        ++self
    }
    
    static func random(min min: Int, max: Int) -> Int {
        if max < min { return min }
        return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
    }
}

extension UIColor {
    static func chartreuseColor() -> UIColor {
        return UIColor(red: 0.875, green: 1, blue: 0, alpha: 1)
    }
}

extension String {
    mutating func trim() {
        self = stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
}

var myInt = 0

myInt.plusOne()

myInt

var otherInt = 10
otherInt.plusOne()

Int.random(min: 1, max: 10)

