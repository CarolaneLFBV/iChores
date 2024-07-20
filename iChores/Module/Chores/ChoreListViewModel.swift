import SwiftUI
import CoreData

@Observable
final class ChoreListViewModel {
    var choreRepository = ChoreRepository()
    var chores: [Chore] = []
    var moc = DataController.shared.viewContext
    
    private func fetch() throws -> [Chore] {
        try ChoreRepository.fetch(context: moc)
    }
    
    func loadData() {
        do {
            chores = try fetch()
        } catch {
            print("Error while loading data, \(error.localizedDescription)")
        }
    }
}
