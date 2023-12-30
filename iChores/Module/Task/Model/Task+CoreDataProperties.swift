//
//  Task+CoreDataProperties.swift
//  iChores
//
//  Created by Carolane Lefebvre on 28/12/2023.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var date: Date?
    @NSManaged public var category: String?
    @NSManaged public var assignedUser: User?
    @NSManaged public var assignedRoom: Room?
    
    public var wrappedTaskTitle: String {
        title ?? "Unknown Title"
    }
    
    public var wrappedTaskID: UUID {
        id ?? UUID()
    }
    
    public var wrappedTaskDate: Date {
        date ?? Date.now
    }
    
    public var wrappedTaskCategory: String {
        category ?? "Unknown Category"
    }
    

}

extension Task : Identifiable {

}
