//
//  RoomModelView.swift
//  iChores
//
//  Created by Carolane Lefebvre on 24/02/2024.
//

import SwiftUI
import CoreData

@Observable
final class RoomViewModel {
    var rooms: [Room] = []
    
    func fetchRooms(context: NSManagedObjectContext) throws {
        rooms = try RoomRepository.fetchRooms(context: context)
    }
    
    func delete(_ room: Room, context: NSManagedObjectContext) throws {
        context.delete(room)
        try context.save()
        try fetchRooms(context: context)
    }
    
    func addRoom(context: NSManagedObjectContext, name: String, type: String) throws {
        let room = Room(context: context)
        room.idRoom = UUID()
        room.name = name
        room.type = type

        try context.save()
        try fetchRooms(context: context)
    }
}
