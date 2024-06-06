import SwiftUI
import CoreData

@Observable
final class AddRoomViewModel {
    var roomRepository = RoomRepository()
    var users: [User] = []
    var moc = DataController.shared.viewContext
    
    private func fetchUsers() throws -> [User] {
        try UserRepository.fetch(context: moc)
    }
    
    func loadData() {
        do {
            users = try fetchUsers()
        } catch {
            print("An error has occured while updating the room: \(error.localizedDescription)")

        }
    }

    func add(name: String, type: String, user: User? = nil) {
        roomRepository.add(name: name, type: type, user: user)
    }
}
