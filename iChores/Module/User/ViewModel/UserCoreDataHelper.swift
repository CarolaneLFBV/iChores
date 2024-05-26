import SwiftUI
import CoreData

@Observable
final class UserCoreDataHelper {
    var users: [User] = []
    var user: User?

    var moc = DataController.shared.viewContext
    
    var showingDeleteAlert = false
    
    func fetch() throws {
        users = try UserRepository.fetchUsers(context: moc)
    }
    
    func delete(_ user: User) throws {
        moc.delete(user)
        try moc.save()
        try fetch()
    }
    
    func isValidName(_ name: String) -> Bool {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-ZÀ-ÖØ-öø-ÿ-]+(?: [a-zA-ZÀ-ÖØ-öø-ÿ-]+){0,9}$", options: .caseInsensitive)
            let range = NSRange(location: 0, length: trimmedName.utf16.count)
            let matches = regex.numberOfMatches(in: trimmedName, options: [], range: range)
            return matches > 0 && trimmedName.count <= 15
        } catch {
            print("Erreur lors de la création de l'expression régulière : \(error.localizedDescription)")
            return false
        }
    }
}
