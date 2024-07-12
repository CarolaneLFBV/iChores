import SwiftUI
import CoreData

@Observable
final class RoomListViewModel {
    var roomRepository = RoomRepository()
    var rooms: [Room] = []
    var moc = DataController.shared.viewContext
    var isEditingRoomsList: Bool = false

    private func fetch() throws -> [Room] {
        try RoomRepository.fetch(context: moc)
    }
    
    func loadData() {
        do {
            rooms = try fetch()
        } catch {
            print("Error while loading data, \(error.localizedDescription)")
        }
    }
    
    func delete(_ room: Room) {
        roomRepository.delete(room)
        loadData()
    }
}
