import Foundation

@Observable
class HomeViewModel {
    var moc = DataController.shared.viewContext
    var users: [User] = []
    var rooms: [Room] = []
    var chores: [Chore] = []

    private func fetchUsers() throws -> [User] {
        try UserRepository.fetch(context: moc)
    }
    
    private func fetchRooms() throws -> [Room] {
        try RoomRepository.fetch(context: moc)
    }
    
    private func fetchChores() throws -> [Chore] {
        try ChoreRepository.fetch(context: moc)
    }
    
    func loadData() {
        do {
            users = try fetchUsers()
            rooms = try fetchRooms()
            chores = try fetchChores()
        } catch {
            print("An error has occured while loading data: \(error.localizedDescription)")
        }
    }
}
