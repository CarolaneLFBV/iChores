import SwiftUI
import CoreData

@Observable
final class UserDetailViewModel {
    var moc = DataController.shared.viewContext
    var user: User?
    var isEditingUser: Bool = false
    var showingDeleteAlert: Bool = false
    var modifiedName: String = ""
    
    var userRepository = UserRepository()
    
    func delete(_ user: User) {
        userRepository.delete(user)
    }
    
    func startEdition(_ user: User) {
        self.user = user
        self.modifiedName = user.name
        self.isEditingUser.toggle()
    }
    
    func update(_ user: User) {
        user.name = modifiedName
        userRepository.update(context: moc)
        self.isEditingUser.toggle()
    }
    
    func isValidName(_ name: String) -> Bool {
        userRepository.isValidName(name)
    }
}
