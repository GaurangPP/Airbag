//
//  CrashImages+CoreDataProperties.swift
//  Airbag
//
//  Created by Gaurang Pendharkar on 10/30/22.
//
//

import Foundation
import CoreData


extension CrashImages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CrashImages> {
        return NSFetchRequest<CrashImages>(entityName: "CrashImages")
    }

    @NSManaged public var id: Int64
    @NSManaged public var storedImage: Data?

}

extension CrashImages : Identifiable {

}
