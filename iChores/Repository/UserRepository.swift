import Foundation
import CoreData
import UIKit

class UserRepository {
    var moc = DataController.shared.viewContext
    var fileManager = FileManager()
    
    enum Error: Swift.Error {
        case fetch, delete, add, update
    }
    
    static func fetch(context: NSManagedObjectContext) throws -> [User] {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.sortDescriptors = []
        
        do {
            return try context.fetch(request)            
        } catch {
            throw Error.fetch
        }
    }
    
    func delete(_ user: User) {
        moc.delete(user)
        do {
            try moc.save()
        } catch {
            print("An error has occured while deleting the user: \(error.localizedDescription)")
        }
    }
    
    func add(name: String, image: UIImage?) {
        let user = User(context: moc)
        user.idUser = UUID()
        user.name = name
        
        do {
            if let image {
                let imageURL = try fileManager.saveImageToDocumentsDirectory(image, fileName: user.idUser)
                user.userImage = imageURL?.absoluteString
            }
            try moc.save()
        } catch {
            print("Error while adding a new user, \(error.localizedDescription)")
        }
    }
    
    func update() {
        do {
            try moc.save()
        } catch {
            print("aaler")
        }
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
