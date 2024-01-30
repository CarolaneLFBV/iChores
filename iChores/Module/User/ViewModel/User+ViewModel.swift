//
//  User+ViewModel.swift
//  iChores
//
//  Created by Carolane Lefebvre on 30/12/2023.
//

import SwiftUI
import CoreData

@Observable
class UserViewModel {
    var users: [User] = []
    var isEditing: Bool = false
    var isSheetPresented: Bool = false
    
    var alertTitle = ""
    var alertMessage = ""
    
    enum UserError: Error {
        case fetchUserError(Error), deleteUserError(Error), addUserError(Error), updateUserError(Error)
    }
    
    func fetchUsers(context: NSManagedObjectContext) throws {
        do {
            let request: NSFetchRequest<User> = User.fetchRequest()
            self.users = try context.fetch(request)
        } catch let error {
            throw UserError.fetchUserError(error)
        }
    }
    
    func deleteUser(at indexSet: IndexSet, context: NSManagedObjectContext) throws {
        
        guard !users.isEmpty else { return }
        
        let selectedUsers: [User] = indexSet.compactMap { index -> User? in
            guard index < users.count else { return nil }
            return users[index]
        }
        
        for user in selectedUsers {
            context.delete(user)
        }
        
        do {
            try context.save()
            try fetchUsers(context: context)
            alertTitle = "User Deleted"
        } catch let error {
            throw UserError.deleteUserError(error)
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
            throw UserError.addUserError(error)
        }
    }
    
    func editUser(user: User, withModifiedName modifiedName: String, context: NSManagedObjectContext) throws {
        user.name = modifiedName
        do {
            try context.save()
        } catch let error {
            throw UserError.updateUserError(error)
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
