//
//  CrashID+CoreDataProperties.swift
//  Airbag
//
//  Created by Gaurang Pendharkar on 10/30/22.
//
//

import Foundation
import CoreData


extension CrashID {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CrashID> {
        return NSFetchRequest<CrashID>(entityName: "CrashID")
    }

    @NSManaged public var id: Int64

}

extension CrashID : Identifiable {

}
