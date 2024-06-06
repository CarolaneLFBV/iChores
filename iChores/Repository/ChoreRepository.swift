import Foundation
import CoreData

class ChoreRepository {
    var chores: [Chore] = []
    var moc = DataController.shared.viewContext
    
    enum Error: Swift.Error {
        case fetch, delete, add, update
    }
    
    static func fetch(context: NSManagedObjectContext) throws -> [Chore] {
        let request: NSFetchRequest<Chore> = Chore.fetchRequest()
        request.sortDescriptors = []
        
        do {
            return try context.fetch(request)
        } catch {
            throw Error.fetch
        }
    }
    
    func addChore(title: String, user: User?, room: Room?) {
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
       
        do {
            try moc.save()
        } catch {
            print("Error while adding new chore: \(error.localizedDescription)")

        }
    }
    
    func delete(_ chore: Chore) {
        moc.delete(chore)
        do {
            try moc.save()
        } catch {
            print("An error has occured while deleting the chore: \(error.localizedDescription)")
        }    }
}
