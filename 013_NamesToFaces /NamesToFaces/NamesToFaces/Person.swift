//
//  Person.swift
//  NamesToFaces
//
//  Created by javan.chen on 2015/10/28.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import UIKit

class Person: NSObject {
    
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
