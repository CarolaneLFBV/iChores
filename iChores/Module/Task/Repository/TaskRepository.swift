import Foundation
import CoreData

class TaskRepository {
        
    enum Error: Swift.Error {
        case fetch, delete, add, update
    }
    
    static func fetchTasks(context: NSManagedObjectContext) throws -> [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.sortDescriptors = []
        
        do {
            return try context.fetch(request)
        } catch {
            throw Error.fetch
        }
    }
}
