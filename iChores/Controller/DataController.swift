//
//  DataController.swift
//  iChores
//
//  Created by Carolane Lefebvre on 28/12/2023.
//

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
