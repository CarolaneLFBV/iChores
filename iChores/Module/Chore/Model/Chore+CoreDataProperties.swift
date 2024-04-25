import Foundation
import CoreData


extension Chore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Chore> {
        return NSFetchRequest<Chore>(entityName: "Chore")
    }

    @NSManaged public var category: String?
    @NSManaged public var date: Date?
    @NSManaged public var idChore: UUID?
    @NSManaged public var isDone: Bool
    @NSManaged public var title: String?
    @NSManaged public var choreToRoom: Room?
    @NSManaged public var choreToUser: User?

     
    public var wrappedChoreTitle: String {
        title ?? "Unknown Title"
    }
    
    public var wrappedChoreID: UUID {
        idChore ?? UUID()
    }
    
    public var wrappedChoreDate: Date {
        date ?? Date.now
    }
    
    public var wrappedChoreCategory: String {
        category ?? "Unknown Category"
    }
}
