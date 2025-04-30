//
//  KickBoard+CoreDataClass.swift
//  SwiftKickBoard
//
//  Created by 허성필 on 4/30/25.
//
//

import Foundation
import CoreData

@objc(KickBoard)
public class KickBoard: NSManagedObject {
    public static let className = "KickBoard"
    public enum Key {
        static let id = "id"
        static let lon = "lon"
        static let lat = "lat"
    }
}
