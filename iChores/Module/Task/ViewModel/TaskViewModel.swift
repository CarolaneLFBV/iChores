import SwiftUI
import CoreData

@Observable
final class TaskViewModel {
    var tasks: [Task] = []
    var task: Task?
    
    func fetchTasks(context: NSManagedObjectContext) throws {
        tasks = try TaskRepository.fetchTasks(context: context)
    }
    
    func addTask(context: NSManagedObjectContext, title: String, category: String, user: User?, room: Room?) throws {
        let task = Task(context: context)
        task.idTask = UUID()
        task.title = title
        task.category = category
//        task.date = date
        task.isDone = false
        
        if let user = user {
            task.taskToUser = user
            user.addToUserToTask(task)
        }
        
        if let room = room {
            task.taskToRoom = room
            room.addToRoomToTask(task)
        }
        
        try context.save()
        try fetchTasks(context: context)
    }
}
