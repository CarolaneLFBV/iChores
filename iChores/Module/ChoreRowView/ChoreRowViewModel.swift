import SwiftUI
import CoreData

@Observable
final class ChoreRowViewModel {
    var choreRepository = ChoreRepository()
    
    func delete(_ chore: Chore) {
        choreRepository.delete(chore)
    }
}
