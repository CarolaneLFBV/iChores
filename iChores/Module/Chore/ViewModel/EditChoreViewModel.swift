import SwiftUI
import CoreData

@Observable
final class EditChoreViewModel {
    var choreCoreDataHelper = ChoreCoreDataHelper()
    
    func update(_ chore: Chore) throws {
        chore.isDone = true
        try choreCoreDataHelper.moc.save()
    }
    
    func delete(_ chore: Chore) throws {
        try choreCoreDataHelper.delete(chore)
    }
    
    func markChoreAsDoneAndDelete(_ chore: Chore) throws {
        try update(chore)
        
        Task {
            try await Task.sleep(for: .seconds(2))
            try await delete(chore)
            try choreCoreDataHelper.fetch()
        }
    }
}
