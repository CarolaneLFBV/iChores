import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "iChores")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data couldn't load: \(error.localizedDescription)")
            }
        }
    }
}
