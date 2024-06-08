import SwiftUI
import CoreData

@Observable
final class UserListViewModel {
    var userRepository = UserRepository()
    var users: [User] = []
    var moc = DataController.shared.viewContext

    var isEditingUsersList: Bool = false
    
    private func fetch() throws -> [User] {
        try UserRepository.fetch(context: moc)
    }
    
    func loadData() {
        do {
            users = try fetch()
        } catch {
            print("Error while loading data, \(error.localizedDescription)")
        }
    }
        
    func delete(_ user: User) {
        userRepository.delete(user)
        loadData()
    }

}
