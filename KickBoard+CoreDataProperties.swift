//
//  KickBoard+CoreDataProperties.swift
//  SwiftKickBoard
//
//  Created by 허성필 on 4/30/25.
//
//

import Foundation
import CoreData


extension KickBoard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<KickBoard> {
        return NSFetchRequest<KickBoard>(entityName: "KickBoard")
    }

    @NSManaged public var lon: Double
    @NSManaged public var lat: Double
    @NSManaged public var id: Int64

}

extension KickBoard : Identifiable {

}
