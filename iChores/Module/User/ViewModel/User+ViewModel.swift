import SwiftUI
import CoreData

@Observable
final class UserViewModel {
    var users: [User] = []
    var coreDataHelper = UserCoreDataHelper()
    var isEditingUser: Bool = false
    var isEditingUsersList: Bool = false
        
    var user: User?
    var modifiedName: String = ""
    
    var moc = DataController.shared.viewContext
    
    func fetchUsers() throws {
        users = try UserRepository.fetchUsers(context: moc)
    }
}
