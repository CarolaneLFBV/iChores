import SwiftUI
import CoreData

@Observable
final class AddChoreViewModel {    
    var choreCoreDataHelper = ChoreCoreDataHelper()
    
    func add(title: String, user: User?, room: Room?) throws {
        let chore = Chore(context: choreCoreDataHelper.moc)
        chore.idChore = UUID()
        chore.title = title
        chore.isDone = false
        
        if let user {
            chore.choreToUser = user
        }
        
        if let room {
            chore.choreToRoom = room
        }
        try choreCoreDataHelper.moc.save()
        try choreCoreDataHelper.fetch()
    }
}
