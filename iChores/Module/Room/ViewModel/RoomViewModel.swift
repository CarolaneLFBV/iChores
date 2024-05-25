import SwiftUI
import CoreData

@Observable
final class RoomViewModel {
    var rooms: [Room] = []
    var room: Room?
    
    var isEditingRoom: Bool = false
    var isEditingRoomsList: Bool = false
    
    var modifiedName: String = ""
    
    var moc = DataController.shared.viewContext
    
    func fetchRooms() throws {
        rooms = try RoomRepository.fetchRooms(context: moc)
    }
    
    func deleteRoom(_ room: Room) throws {
        moc.delete(room)
        try moc.save()
        try fetchRooms()
    }
    
    func addRoom(name: String, type: String, user: User? = nil) throws {
        let room = Room(context: moc)
        room.idRoom = UUID()
        room.name = name
        room.type = type
        
        if let user {
            room.roomToUser = user
        }
            
        try moc.save()
        try fetchRooms()
    }
    
    func startEdition(room: Room) {
        self.room = room
        self.modifiedName = room.name
        self.isEditingRoom = true
    }
    
    func updateRoom() throws {
        guard let room = room else { return }
        room.name = modifiedName
        try moc.save()
        isEditingRoom = false
    }
    
    func isRoomNameValid() -> Bool {
        return modifiedName.count <= 15
    }
}
