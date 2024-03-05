//
//  UserRepository.swift
//  iChores
//
//  Created by Carolane Lefebvre on 07/02/2024.
//

import Foundation
import CoreData

class UserRepository {
        
    enum Error: Swift.Error {
        case fetch, delete, add, update
    }
    
    static func fetchUsers(context: NSManagedObjectContext) throws -> [User] {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.sortDescriptors = []
        
        do {
            return try context.fetch(request)            
        } catch {
            throw Error.fetch
        }
    }
}
