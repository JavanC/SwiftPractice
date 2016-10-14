//
//  main.swift
//  EncryptCommandLine
//
//  Created by javan.chen on 2015/10/15.
//  Copyright © 2015年 javan.chen. All rights reserved.
//

var demo = Encrypt()
var a1 = "There is no spoon"
print(a1)
var a2 = demo.toEncode(a1)
print(a2)
var a3 = demo.toDecode(a2)
print(a3)


