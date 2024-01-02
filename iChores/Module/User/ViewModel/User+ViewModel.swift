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
        let selectedUsers = indexSet.map { users[$0] }
        
        for user in selectedUsers {
            context.delete(user)
        }
        
        do {
            try context.save()
            try fetchUsers(context: context)
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
}