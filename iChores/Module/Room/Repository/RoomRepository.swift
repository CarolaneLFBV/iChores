import Foundation
import CoreData

class RoomRepository {
        
    enum Error: Swift.Error {
        case fetch, delete, add, update
    }
    
    static func fetchRooms(context: NSManagedObjectContext) throws -> [Room] {
        let request: NSFetchRequest<Room> = Room.fetchRequest()
        request.sortDescriptors = []
        
        do {
            return try context.fetch(request)
        } catch {
            throw Error.fetch
        }
    }
}
