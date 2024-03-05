//
//  RoomDetailView.swift
//  iChores
//
//  Created by Carolane Lefebvre on 24/02/2024.
//

import SwiftUI

struct RoomDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State var roomViewModel: RoomViewModel
    
    let room: Room
    
    var body: some View {
        VStack {
            Text(room.wrappedRoomName)
            Text(room.wrappedRoomType)
            
            Button("Delete") {
                do {
                    try roomViewModel.delete(room, context: moc)
                    dismiss()
                } catch {
                    print("ERROR DELETING")
                }
            }
        }
    }
}
