import SwiftUI
import CoreData

@Observable
final class RoomDetailViewModel {
    var room: Room?

    var isEditingRoom: Bool = false
    var isEditingRoomList: Bool = false
    
    var roomCoreDataHelper = RoomCoreDataHelper()
    
    func delete(_ room: Room) throws {
        try roomCoreDataHelper.delete(room)
    }
    
    func edit(room: Room) {
        self.room = room
        roomCoreDataHelper.modifiedName = room.name
        isEditingRoom = true
    }
    
    func update() throws {
        guard let room = room else { return }
        room.name = roomCoreDataHelper.modifiedName
        try roomCoreDataHelper.moc.save()
        isEditingRoom = false
    }
    
    func isRoomNameValid() -> Bool {
        return roomCoreDataHelper.modifiedName.count <= 15
    }
}
