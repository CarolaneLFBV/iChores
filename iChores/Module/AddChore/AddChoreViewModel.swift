import SwiftUI
import CoreData

@Observable
final class AddChoreViewModel {    
    var choreRepository = ChoreRepository()
    var users: [User] = []
    var rooms: [Room] = []
    var moc = DataController.shared.viewContext

    private func fetchUsers() throws -> [User] {
        try UserRepository.fetch(context: moc)
    }
    
    private func fetchRooms() throws -> [Room] {
        try RoomRepository.fetch(context: moc)
    }
    
    func loadData() {
        do {
            users = try fetchUsers()
            rooms = try fetchRooms()
        } catch {
            print("An error has occured while loading data: \(error.localizedDescription)")
        }
    }
    
    func add(title: String, user: User?, room: Room?) {
        choreRepository.addChore(title: title, user: user, room: room)
    }
}
