//
//  Encrypt.swift
//  EncryptCommandLine
//
//  Created by javan.chen on 2015/10/15.
//  Copyright © 2015年 javan.chen. All rights reserved.
//

import Cocoa

class Encrypt: NSObject, NSCoding {
    //英文小寫字母表
    var alphabet = "abcdefghijklmnopqrstuvwxyz"
    //密碼表整數陣列
    var code = [Int]()
    //a,b暫時提升為屬性
    var a = 0, b = 0
    
    //建構子
    override init() {
        super.init()
        setCode()
    }
    
    //NSCoding 的建構子
    required init(coder decoder: NSCoder) {
        super.init()
        alphabet = decoder.decodeObjectForKey("alphabet") as! String
        code = decoder.decodeObjectForKey("code") as! Array
    }
    
    //NSCoding 的方法
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(alphabet, forKey: "alphabet")
        aCoder.encodeObject(code, forKey: "code")
    }
    
    //設定密碼表
    func setCode() {
        //a設定為奇數
        while a % 2 == 0{
            a = Int(arc4random() % 10)
            b = Int(arc4random() % 10)
        }
        var c = 97
        var y, m: Int
        //以迴圈取得每一個餘數
        for _ in 0...25 {
            y = c * a + b
            m = y % 26
            code.append(m)
            c++
        }
    }
    
    //判斷是否為英文小寫字母
    func isLowercase(chr: Character)->Bool {
        for i in alphabet.characters {
            if (chr == i) {
                return true
            }
        }
        return false
    }
    
    //由字元從字母中找到索引值
    func findAlphabetIndex(chr: Character)->Int {
        var i = 0
        for c in alphabet.characters {
            if chr == c {
                return i
            }
            i++
        }
        return 0
    }
    
    //由索引值找到密碼表中對應的字元
    func findCode(number: Int)->Character {
        let index = code[number]
        var i = 0
        for s in alphabet.characters {
            if i == index {
                return s
            }
            i++
        }
        return Character("")
    }
    
    //進行編碼方法
    func toEncode(str: String)->String {
        var newStr = ""
        for chr in str.characters{
            if isLowercase(chr) {
                newStr.append(findCode(findAlphabetIndex(chr)))
            }
            else{
                newStr.append(chr)
            }
        }
        return newStr
    }
    
    //由字元從密碼表中找到索引值
    func findCodeIndex(chr: Character)->Int {
        let n = findAlphabetIndex(chr)
        var i = 0
        for d in code {
            if d == n {
                return i
            }
            i++
        }
        return -1
    }
    
    //由索引值找到字母表中對應的字元
    func findLetter(index: Int)->Character {
        var i = 0
        for s in alphabet.characters {
            if i == index {
                return s
            }
            i++
        }
        return Character("")
    }
    
    //進行解碼的方法
    func toDecode(str: String)->String {
        var newStr = ""
        for chr in str.characters {
            if isLowercase(chr) {
                newStr.append(findLetter(findCodeIndex(chr)))
            }
            else {
                newStr.append(chr)
            }
        }
        return newStr
    }
}
