//
//  MyBeacon+CoreDataProperties.swift
//  DetectBeacon
//
//  Created by Javan.Chen on 2017/2/3.
//  Copyright © 2017年 Javan chen. All rights reserved.
//

import Foundation
import CoreData


extension MyBeacon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyBeacon> {
        return NSFetchRequest<MyBeacon>(entityName: "MyBeacon");
    }

    @NSManaged public var name: String?
    @NSManaged public var uuid: String?
    @NSManaged public var major: String?
    @NSManaged public var minor: String?

}
