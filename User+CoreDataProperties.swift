//
//  User+CoreDataProperties.swift
//  iChores
//
//  Created by Carolane Lefebvre on 25/04/2024.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var idUser: UUID
    @NSManaged public var name: String
    @NSManaged public var userImage: String?
    @NSManaged public var userToChore: NSSet
    @NSManaged public var userToRoom: NSSet
    
    public var userRoomArray: [Room] {
        guard let set = userToRoom as? Set<Room> else { return [] }
        return set.sorted {
            $0.name < $1.name
        }
    }
    
    public var userChoreArray: [Chore] {
        guard let set = userToChore as? Set<Chore> else { return [] }
        return set.sorted {
            $0.title < $1.title
        }
    }

}

// MARK: Generated accessors for userToChore
extension User {

    @objc(addUserToChoreObject:)
    @NSManaged public func addToUserToChore(_ value: Chore)

    @objc(removeUserToChoreObject:)
    @NSManaged public func removeFromUserToChore(_ value: Chore)

    @objc(addUserToChore:)
    @NSManaged public func addToUserToChore(_ values: NSSet)

    @objc(removeUserToChore:)
    @NSManaged public func removeFromUserToChore(_ values: NSSet)

}

// MARK: Generated accessors for userToRoom
extension User {

    @objc(addUserToRoomObject:)
    @NSManaged public func addToUserToRoom(_ value: Room)

    @objc(removeUserToRoomObject:)
    @NSManaged public func removeFromUserToRoom(_ value: Room)

    @objc(addUserToRoom:)
    @NSManaged public func addToUserToRoom(_ values: NSSet)

    @objc(removeUserToRoom:)
    @NSManaged public func removeFromUserToRoom(_ values: NSSet)

}

extension User : Identifiable {

}
