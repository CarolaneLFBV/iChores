import SwiftUI
import CoreData

@Observable
final class AddRoomViewModel {
    var roomCoreDataHelper = RoomCoreDataHelper()

    func add(name: String, type: String, user: User? = nil) throws {
        let room = Room(context: roomCoreDataHelper.moc)
        room.idRoom = UUID()
        room.name = name
        room.type = type
        
        if let user {
            room.roomToUser = user
        }
            
        try roomCoreDataHelper.moc.save()
        try roomCoreDataHelper.fetch()
    }
}
