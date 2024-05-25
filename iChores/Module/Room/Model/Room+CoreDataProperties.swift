//
//  Room+CoreDataProperties.swift
//  iChores
//
//  Created by Carolane Lefebvre on 25/04/2024.
//
//

import Foundation
import CoreData


extension Room {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Room> {
        return NSFetchRequest<Room>(entityName: "Room")
    }

    @NSManaged public var idRoom: UUID
    @NSManaged public var name: String
    @NSManaged public var type: String
    @NSManaged public var roomToChore: NSSet
    @NSManaged public var roomToUser: User
    
    public var roomChoreArray: [Chore] {
        guard let set = roomToChore as? Set<Chore> else { return [] }
        return set.sorted {
            $0.title < $1.title
        }
    }
}

// MARK: Generated accessors for roomToChore
extension Room {

    @objc(addRoomToChoreObject:)
    @NSManaged public func addToRoomToChore(_ value: Chore)

    @objc(removeRoomToChoreObject:)
    @NSManaged public func removeFromRoomToChore(_ value: Chore)

    @objc(addRoomToChore:)
    @NSManaged public func addToRoomToChore(_ values: NSSet)

    @objc(removeRoomToChore:)
    @NSManaged public func removeFromRoomToChore(_ values: NSSet)

}

extension Room : Identifiable {

}
