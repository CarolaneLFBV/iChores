//
//  Chore+CoreDataProperties.swift
//  iChores
//
//  Created by Carolane Lefebvre on 27/04/2024.
//
//

import Foundation
import CoreData


extension Chore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Chore> {
        return NSFetchRequest<Chore>(entityName: "Chore")
    }

    @NSManaged public var idChore: UUID?
    @NSManaged public var isDone: Bool
    @NSManaged public var title: String?
    @NSManaged public var choreToRoom: Room?
    @NSManaged public var choreToUser: User?

}

extension Chore : Identifiable {

}
