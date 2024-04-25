import SwiftUI
import CoreData

@Observable
final class RoomViewModel {
    var rooms: [Room] = []
    var room: Room?
    
    var isEditingRoom: Bool = false
    var isEditingRoomsList: Bool = false
    
    var modifiedName: String = ""
    
    func fetchRooms(context: NSManagedObjectContext) throws {
        rooms = try RoomRepository.fetchRooms(context: context)
    }
    
    func delete(_ room: Room, context: NSManagedObjectContext) throws {
        context.delete(room)
        try context.save()
        print(context)
        try fetchRooms(context: context)
    }
    
    func addRoom(context: NSManagedObjectContext, name: String, type: String, user: User? = nil) throws {
        let room = Room(context: context)
        room.idRoom = UUID()
        room.name = name
        room.type = type
        
        if let user {
            room.roomToUser = user
        }
            
        try context.save()
        try fetchRooms(context: context)
    }
    
    func startEdition(room: Room) {
        self.room = room
        self.modifiedName = room.name
        self.isEditingRoom = true
    }
    
    func updateRoom(context: NSManagedObjectContext) throws {
        guard let room = room else { return }
        room.name = modifiedName
        try context.save()
        isEditingRoom = false
    }
    
    func isRoomNameValid() -> Bool {
        return modifiedName.count <= 15
    }
}
