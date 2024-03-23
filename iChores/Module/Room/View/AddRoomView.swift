//
//  AddRoomView.swift
//  iChores
//
//  Created by Carolane Lefebvre on 24/02/2024.
//

import SwiftUI

struct AddRoomView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State var roomViewModel: RoomViewModel

    @State private var roomName = ""
    @State private var test = ""
    
    let typeRoom = ["Entrance", "Living Room", "Bedroom", "Kitchen", "Bathroom", "WC", "Garden", "Dressing Room"]
    @State private var selectedRoom = "Entrance"    
    
    var body: some View {
        VStack {
            TextField("Room name", text: $roomName)
                .textFieldStyle()
            
            Picker("Room", selection: $selectedRoom) {
                ForEach(typeRoom, id: \.self) { type in
                    Text(type)
                }
            }
            .foregroundStyle(.black)
            .pickerStyle(.navigationLink)
            .textFieldStyle()
            
            TextField("Belongs to...", text: $test)
                .textFieldStyle()
            
            Button {
                do {
                    try roomViewModel.addRoom(context: moc, name: roomName, type: selectedRoom)
                } catch {
                    print("ERROR")
                }
            } label: {
                Text("Create")
                    .foregroundStyle(.white)
            }
            .primaryButtonStyle()
        }
    }
}

