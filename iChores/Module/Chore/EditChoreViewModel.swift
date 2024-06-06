import SwiftUI
import CoreData

@Observable
final class EditChoreViewModel {
    var choreRepository = ChoreRepository()
    
    func delete(_ chore: Chore) {
        choreRepository.delete(chore)
    }
}
