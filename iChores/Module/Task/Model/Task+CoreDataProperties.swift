import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var category: String?
    @NSManaged public var date: Date?
    @NSManaged public var idTask: UUID?
    @NSManaged public var title: String?
    @NSManaged public var taskToRoom: Room?
    @NSManaged public var taskToUser: User?

    public var wrappedTaskTitle: String {
        title ?? "Unknown Title"
    }
    
    public var wrappedTaskID: UUID {
        idTask ?? UUID()
    }
    
    public var wrappedTaskDate: Date {
        date ?? Date.now
    }
    
    public var wrappedTaskCategory: String {
        category ?? "Unknown Category"
    }
    
}
