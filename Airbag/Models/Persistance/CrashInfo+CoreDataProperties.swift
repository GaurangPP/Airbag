//
//  CrashInfo+CoreDataProperties.swift
//  Airbag
//
//  Created by Gaurang Pendharkar on 10/30/22.
//
//

import Foundation
import CoreData


extension CrashInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CrashInfo> {
        return NSFetchRequest<CrashInfo>(entityName: "CrashInfo")
    }

    @NSManaged public var address: String?
    @NSManaged public var date: String?
    @NSManaged public var id: Int64
    @NSManaged public var insuranceCarrier: String?
    @NSManaged public var licenseNumber: String?
    @NSManaged public var location: String?
    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var plateNumber: String?
    @NSManaged public var policyNumber: String?
    @NSManaged public var time: String?
    @NSManaged public var vehicleDetails: String?
    @NSManaged public var vinNumber: String?
    @NSManaged public var notes: String?

}

extension CrashInfo : Identifiable {

}
