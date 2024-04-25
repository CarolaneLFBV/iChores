import Foundation
import CoreData

class ChoreRepository {
        
    enum Error: Swift.Error {
        case fetch, delete, add, update
    }
    
    static func fetchChores(context: NSManagedObjectContext) throws -> [Chore] {
        let request: NSFetchRequest<Chore> = Chore.fetchRequest()
        request.sortDescriptors = []
        
        do {
            return try context.fetch(request)
        } catch {
            throw Error.fetch
        }
    }
}
