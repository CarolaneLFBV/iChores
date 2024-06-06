import SwiftUI
import CoreData

@Observable
final class RoomDetailViewModel {
    var roomRepository = RoomRepository()
    var room: Room?
    var isEditingRoom: Bool = false
    var isEditingRoomList: Bool = false
    var modifiedName: String = ""
    
    func delete(_ room: Room) {
        roomRepository.delete(room)
    }
    
    func edit(_ room: Room) {
        self.room = room
        modifiedName = room.name
        isEditingRoom = true
    }
    
    func update(_ room: Room) {
        roomRepository.update()
        isEditingRoom = false
    }
    
    func isRoomNameValid() -> Bool {
        return modifiedName.count <= 15
    }
}
