import SwiftUI
import CoreData

@Observable
final class UserViewModel {
    var users: [User] = []
    var isEditingUser: Bool = false
    var isEditingUsersList: Bool = false
    var showingImagePicker: Bool = false
    
    var fileManager = FileManager()
    
    var user: User?
    var modifiedName: String = ""
    
    func fetchUsers(context: NSManagedObjectContext) throws {
        users = try UserRepository.fetchUsers(context: context)
    }
    
    func delete(_ user: User, context: NSManagedObjectContext) throws {
        context.delete(user)
        try context.save()
        try fetchUsers(context: context)
    }
    
    func addUser(context: NSManagedObjectContext, name: String, image: UIImage?) throws {
        let user = User(context: context)
        user.idUser = UUID()
        user.name = name
        
        if let image {
            let imageURL = try fileManager.saveImageToDocumentsDirectory(image, fileName: user.idUser)
            user.userImage = imageURL?.absoluteString
        }
        
        try context.save()
        try fetchUsers(context: context)
    }
    
    func startEdition(user: User) {
        self.user = user
        self.modifiedName = user.name
        self.isEditingUser.toggle()
    }
    
    func updateUser(context: NSManagedObjectContext) throws {
        guard let user = user else { return }
        user.name = modifiedName
        try context.save()
        isEditingUser = false
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
