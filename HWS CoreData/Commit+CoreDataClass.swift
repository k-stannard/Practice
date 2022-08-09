//
//  Commit+CoreDataClass.swift
//  HWS CoreData
//
//  Created by Koty Stannard on 8/7/22.
//
//

import Foundation
import CoreData

@objc(Commit)
public class Commit: NSManagedObject {
    override public init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        print("init called")
    }
}
