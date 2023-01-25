//
//  UserContact+CoreDataProperties.swift
//  Airbag
//
//  Created by Gaurang Pendharkar on 10/29/22.
//
//

import Foundation
import CoreData


extension UserContact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserContact> {
        return NSFetchRequest<UserContact>(entityName: "UserContact")
    }

    @NSManaged public var address: String?
    @NSManaged public var name: String?
    @NSManaged public var number: String?
    @NSManaged public var user: Bool
    @NSManaged public var licenseNumber: String?
    @NSManaged public var plateNumber: String?
    @NSManaged public var vinNumber: String?
    @NSManaged public var insuranceCarrier: String?
    @NSManaged public var policyNumber: String?

}

extension UserContact : Identifiable {

}
