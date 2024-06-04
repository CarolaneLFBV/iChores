import SwiftUI
import CoreData

@Observable
final class EditChoreViewModel {
    var choreCoreDataHelper = ChoreCoreDataHelper()
    
    func update(_ chore: Chore) throws {
        chore.isDone.toggle()
        try choreCoreDataHelper.moc.save()
    }
    
    func delete(_ chore: Chore) throws {
        try choreCoreDataHelper.delete(chore)
    }
    
    func markChoreAsDoneAndDelete(_ chore: Chore) async throws {
        try update(chore)
        try await Task.sleep(for: .seconds(2))
        try delete(chore)
        try choreCoreDataHelper.fetch()
    }
}
