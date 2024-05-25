import SwiftUI
import CoreData

@Observable
final class ChoreViewModel {
    var chores: [Chore] = []
    var chore: Chore?
    
    var moc = DataController.shared.viewContext
    
    func fetchChores() throws {
        chores = try ChoreRepository.fetchChores(context: moc)
    }
    
    func addChore(title: String, user: User?, room: Room?) throws {
        let chore = Chore(context: moc)
        chore.idChore = UUID()
        chore.title = title
        chore.isDone = false
        
        if let user {
            chore.choreToUser = user
        }
        
        if let room {
            chore.choreToRoom = room
        }
            
        try moc.save()
        try fetchChores()
    }
    
    func deleteChore(_ chore: Chore) throws {
        moc.delete(chore)
        try moc.save()
        try fetchChores()
    }
}

