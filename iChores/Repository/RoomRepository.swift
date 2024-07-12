import Foundation
import CoreData

class RoomRepository {
    var rooms: [Room] = []
    var modifiedName: String = ""
    
    var moc = DataController.shared.viewContext
    
    enum Error: Swift.Error {
        case fetch, delete, add, update
    }
    
    static func fetch(context: NSManagedObjectContext) throws -> [Room] {
        let request: NSFetchRequest<Room> = Room.fetchRequest()
        request.sortDescriptors = []
        
        do {
            return try context.fetch(request)
        } catch {
            throw Error.fetch
        }
    }

    func update(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("Erroe while updating: \(error.localizedDescription)")
        }
    }
    
    func delete(_ room: Room) {
        moc.delete(room)
        do {
            try moc.save()
        } catch {
            print("An error has occured while deleting the room: \(error.localizedDescription)")
        }
    }
    
    func add(name: String, type: String, user: User? = nil) {
        let room = Room(context: moc)
        room.idRoom = UUID()
        room.name = name
        room.type = type
        
        if let user {
            room.roomToUser = user
        }
        
        do {
            try moc.save()
        } catch {
            print("Error while adding new room: \(error.localizedDescription)")
        }
    }
    
    func isValidName() -> Bool {
        return modifiedName.count <= 15
    }
}
