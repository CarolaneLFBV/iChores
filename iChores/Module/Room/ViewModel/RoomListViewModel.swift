import SwiftUI
import CoreData

@Observable
final class RoomListViewModel {
    var roomCoreDataHelper = RoomCoreDataHelper()
    var room: Room?
    
    var isEditingRoomsList: Bool = false
    
    func delete(_ room: Room) throws {
        try roomCoreDataHelper.delete(room)
    }
}
