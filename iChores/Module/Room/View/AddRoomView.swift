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
    @State var userViewModel: UserViewModel
    
    @State private var roomName = ""
    @State private var selectedRoom = "Entrance"
    let typeRoom = ["Entrance", "Living Room", "Bedroom", "Kitchen", "Bathroom", "WC", "Garden", "Dressing Room"]
    
    @State private var selectedUser: User?
    
    var body: some View {
        VStack {
            TextField("Room name", text: $roomName)
                .textFieldStyle()
            
            Picker("Room", selection: $selectedRoom) {
                ForEach(typeRoom, id: \.self) { type in
                    Text(type)
                }
            }
            .pickerStyle(.navigationLink)
            .textFieldStyle()
            
            Picker("Belongs to...", selection: $selectedUser) {
                HStack {
                    Image(systemName: "person.fill")
                    Text("None")
                }
                .tag(nil as User?)
                
                ForEach(userViewModel.users, id: \.self) { user in
                    HStack {
                        UserProfileImage(user: user).roomUserImage
                        Text(user.wrappedUserName)
                    }
                    .tag(user as User?)
                }
            }
            .pickerStyle(.navigationLink)
            .textFieldStyle()
            .onAppear {
                try? userViewModel.fetchUsers(context: moc)
            }
            
            Button {
                do {
                    try roomViewModel.addRoom(context: moc, name: roomName, type: selectedRoom, user: selectedUser)
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

