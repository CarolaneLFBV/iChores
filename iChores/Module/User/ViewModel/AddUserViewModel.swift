import SwiftUI
import CoreData

@Observable
final class AddUserViewModel {
    var users: [User] = []
    var showingImagePicker: Bool = false
    var userCoreDataHelper = UserCoreDataHelper()
    
    var fileManager = FileManager()
    
    var user: User?
    
    var moc = DataController.shared.viewContext
    
    func fetchUsers() throws {
        users = try UserRepository.fetchUsers(context: moc)
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
