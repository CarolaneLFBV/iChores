import SwiftUI
import CoreData

@Observable
final class RoomCoreDataHelper {
    var rooms: [Room] = []
    var room: Room?
    
    var modifiedName: String = ""
    
    var moc = DataController.shared.viewContext
    
    func fetch() throws {
        rooms = try RoomRepository.fetchRooms(context: moc)
    }
    
    func delete(_ room: Room) throws {
        moc.delete(room)
        try moc.save()
        try fetch()
    }
    
    func add(name: String, type: String, user: User? = nil) throws {
        let room = Room(context: moc)
        room.idRoom = UUID()
        room.name = name
        room.type = type
        
        if let user {
            room.roomToUser = user
        }
            
        try moc.save()
        try fetch()
    }
    
    func isValidName() -> Bool {
        return modifiedName.count <= 15
    }
}
