//
//  User+ViewModel.swift
//  iChores
//
//  Created by Carolane Lefebvre on 30/12/2023.
//

import SwiftUI
import CoreData

@Observable
final class UserViewModel {
    var users: [User] = []
    var isEditing: Bool = false
    var isSheetPresented: Bool = false
    
    var alertTitle = ""
    var alertMessage = ""
        
    enum UserError: Error {
        case fetch(Error), delete(Error), add(Error), update(Error)
    }
    
    func fetchUsers(context: NSManagedObjectContext) throws {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.sortDescriptors = []
        
        do {
            self.users = try context.fetch(request)
        } catch let error {
            throw UserError.fetch(error)
        }
    }
    
    func delete(_ user: User, context: NSManagedObjectContext) throws {
        context.delete(user)
        do {
            try context.save()
            try fetchUsers(context: context)
        } catch let error {
            throw UserError.delete(error)
        }
    }
    
    func addUser(context: NSManagedObjectContext, name: String, image: UIImage?) throws {
        let user = User(context: context)
        user.id = UUID()
        user.name = name
        
        if let imageData = image?.jpegData(compressionQuality: 1.0) {
            let base64String = imageData.base64EncodedString()
            user.userImage = base64String
        }

        do {
            try context.save()
            try fetchUsers(context: context)
            alertTitle = "User Created"
        } catch let error {
            throw UserError.add(error)
        }
    }
    
    func updateUser(context: NSManagedObjectContext) throws {        
        do {
            try context.save()
        } catch let error {
            throw UserError.update(error)
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
