import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String?
    @NSManaged public var userImage: String?
    @NSManaged public var userToRoom: NSSet?
    @NSManaged public var userToTask: NSSet?
    
    public var wrappedUserName: String {
        name ?? "Unknown User Name"
    }

    public var wrappedUserImage: String {
        userImage ?? "No Image available"
    }
    
    public var userRoomArray: [Room] {
        let set = userToRoom as? Set<Room> ?? []
        return set.sorted {
            $0.wrappedRoomName < $1.wrappedRoomName
        }
    }
    
    public var userTaskArray: [Task] {
        let set = userToTask as? Set<Task> ?? []
        return set.sorted {
            $0.wrappedTaskTitle < $1.wrappedTaskTitle
        }
    }

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

// MARK: Generated accessors for userToTask
extension User {

    @objc(addUserToTaskObject:)
    @NSManaged public func addToUserToTask(_ value: Task)

    @objc(removeUserToTaskObject:)
    @NSManaged public func removeFromUserToTask(_ value: Task)

    @objc(addUserToTask:)
    @NSManaged public func addToUserToTask(_ values: NSSet)

    @objc(removeUserToTask:)
    @NSManaged public func removeFromUserToTask(_ values: NSSet)

}

extension User : Identifiable {

}
