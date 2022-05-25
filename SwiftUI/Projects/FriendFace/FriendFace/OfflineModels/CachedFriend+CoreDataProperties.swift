//
//  CachedFriend+CoreDataProperties.swift
//  FriendFace
//
//  Created by Mehmet Ateş on 25.05.2022.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var friend: CachedUser?
    
    var wrappedId: String { id ?? UUID().uuidString }
    var wrappedName: String { name ?? "Unknowed" }

    

}

extension CachedFriend : Identifiable {

}
