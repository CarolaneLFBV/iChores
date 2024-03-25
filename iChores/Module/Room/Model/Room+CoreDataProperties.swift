import Foundation
import CoreData


extension Room {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Room> {
        return NSFetchRequest<Room>(entityName: "Room")
    }

    @NSManaged public var idRoom: UUID
    @NSManaged public var name: String?
    @NSManaged public var roomImage: String?
    @NSManaged public var type: String?
    @NSManaged public var roomToTask: NSSet?
    @NSManaged public var roomToUser: User?

    public var wrappedRoomName: String {
        name ?? "Unknown Room Name"
    }
    
    public var wrappedRoomType: String {
        type ?? "Unknown Type"
    }
    
    public var wrappedRoomImage: String {
        roomImage ?? "No image available"
    }
    
    public var roomTaskArray: [Task] {
        let set = roomToTask as? Set<Task> ?? []
        return set.sorted {
            $0.wrappedTaskTitle < $1.wrappedTaskTitle
        }
    }
}

// MARK: Generated accessors for roomToTask
extension Room {

    @objc(addRoomToTaskObject:)
    @NSManaged public func addToRoomToTask(_ value: Task)

    @objc(removeRoomToTaskObject:)
    @NSManaged public func removeFromRoomToTask(_ value: Task)

    @objc(addRoomToTask:)
    @NSManaged public func addToRoomToTask(_ values: NSSet)

    @objc(removeRoomToTask:)
    @NSManaged public func removeFromRoomToTask(_ values: NSSet)

}

extension Room : Identifiable {

}
