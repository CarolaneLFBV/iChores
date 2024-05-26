import SwiftUI
import CoreData

@Observable
final class UserDetailViewModel {
    var user: User?

    var coreDataHelper = UserCoreDataHelper()
    
    var isEditingUser: Bool = false
    var modifiedName: String = ""
    
    func delete(user: User) throws {
        try coreDataHelper.delete(user)
    }
    
    func startEdition(user: User) {
        self.user = user
        self.modifiedName = user.name
        self.isEditingUser.toggle()
    }
    
    func update(user: User) throws {
        user.name = modifiedName
        try coreDataHelper.moc.save()
        isEditingUser = false
        try coreDataHelper.fetch()
    }
    
    func isValidName(_ name: String) -> Bool {
        coreDataHelper.isValidName(name)
    }
}
