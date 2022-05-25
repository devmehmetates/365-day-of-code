//
//  CachedUser+CoreDataProperties.swift
//  FriendFace
//
//  Created by Mehmet Ateş on 25.05.2022.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var registered: String?
    @NSManaged public var tags: [NSString]?
    @NSManaged public var friends: NSObject?
    @NSManaged public var original: NSSet?
    
    
    var wrappedId: String { id ?? UUID().uuidString }
    var wrappedName: String { name ?? "Unknowed" }
    var wrappedAbout: String { about ?? "Unknowed" }
    var wrappedAddress: String { address ?? "Unknowed" }
    var wrappedCompany: String { company ?? "Unknowed" }
    var wrappedEmail: String { email ?? "Unknowed" }
    var wrappedRegistered: String { registered ?? "Unknowed" }
    var wrappedTags: [NSString] { tags ?? [] }
    
    public var friendArray: [CachedFriend] {
        let set = original as? Set<CachedFriend> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }

}

// MARK: Generated accessors for original
extension CachedUser {

    @objc(addOriginalObject:)
    @NSManaged public func addToOriginal(_ value: CachedFriend)

    @objc(removeOriginalObject:)
    @NSManaged public func removeFromOriginal(_ value: CachedFriend)

    @objc(addOriginal:)
    @NSManaged public func addToOriginal(_ values: NSSet)

    @objc(removeOriginal:)
    @NSManaged public func removeFromOriginal(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
