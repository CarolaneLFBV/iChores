import SwiftUI
import CoreData

@Observable
final class UserListViewModel {
    var coreDataHelper = UserCoreDataHelper()
    
    var isEditingUsersList: Bool = false
        
    func delete(_ user: User) throws {
        try coreDataHelper.delete(user)
    }
}
