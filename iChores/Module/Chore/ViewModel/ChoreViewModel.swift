import SwiftUI
import CoreData

@Observable
final class ChoreViewModel {
    var chores: [Chore] = []
    var chore: Chore?
    
    func fetchChores(context: NSManagedObjectContext) throws {
        chores = try ChoreRepository.fetchChores(context: context)
    }
    
    func addChore(context: NSManagedObjectContext, title: String, user: User?, room: Room?) throws {
        let chore = Chore(context: context)
        chore.idChore = UUID()
        chore.title = title
        chore.isDone = false
        
        if let user {
            chore.choreToUser = user
        }
        
        if let room {
            chore.choreToRoom = room
        }
            
        try context.save()
        try fetchChores(context: context)
    }
    
    func markChoreAsDone(_ chore: Chore, context: NSManagedObjectContext) throws {
        chore.isDone = true
        try deleteChore(chore, context: context)
    }    
    
    func deleteChore(_ chore: Chore, context: NSManagedObjectContext) throws {
        context.delete(chore)
        try context.save()
        try fetchChores(context: context)
    }
}

