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
    
    var moc = DataController.shared.viewContext
    
    func fetchUsers() throws {
        users = try UserRepository.fetchUsers(context: moc)
    }
    
    func delete(_ user: User) throws {
        moc.delete(user)
        try moc.save()
        try fetchUsers()
    }
    
    func addUser(name: String, image: UIImage?) throws {
        let user = User(context: moc)
        user.idUser = UUID()
        user.name = name
        
        if let image {
            let imageURL = try fileManager.saveImageToDocumentsDirectory(image, fileName: user.idUser)
            user.userImage = imageURL?.absoluteString
        }
        
        try moc.save()
        try fetchUsers()
    }
    
    func startEdition(user: User) {
        self.user = user
        self.modifiedName = user.name
        self.isEditingUser.toggle()
    }
    
    func updateUser() throws {
        guard let user = user else { return }
        user.name = modifiedName
        try moc.save()
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
