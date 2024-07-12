import SwiftUI

struct RoomDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State var roomDetailViewModel = RoomDetailViewModel()
    @State private var showingDeleteAlert: Bool = false
    @State private var roomToDelete: Room?
    
    let room: Room
    
    var body: some View {
        ZStack {
            Color("AppBackgroundColor")
                .ignoresSafeArea()

            VStack {
                header
                
                Components.DividerSpacer(height: 40)
                
                if roomDetailViewModel.isEditingRoom {
                    roomEdition
                } else {
                    roomDetail
                }
            }
            .padding()
        }
    }
}

extension RoomDetailView {
    var roomEditButtons: some View {
        HStack {
            Button {
                roomDetailViewModel.isEditingRoomList = false
                roomDetailViewModel.isEditingRoom = false
            } label: {
                Text("Cancel")
                    .padding()
            }
            .secondaryButtonStyle()
            
            Button {
                showingDeleteAlert = true
                roomToDelete = room
            } label: {
                Text("Delete")
                    .padding()
            }
            .deleteButtonStyle()
        }
    }
}

extension RoomDetailView {
    var roomDetail: some View {
        UsersAndTasks(room: room)
        .toolbar {
            Button("Edit") {
                roomDetailViewModel.edit(room)
            }
        }
    }
    
    var roomEdition: some View {
        ScrollView {
            TextField("Room's name", text: $roomDetailViewModel.modifiedName)
                .textFieldStyle()
            
            Components.DividerSpacer(height: 40)

            UsersAndTasks(room: room)
            
            roomEditButtons
        }
        .toolbar {
            updateButton
        }
        .confirmationAlert(
            isPresented: $showingDeleteAlert,
            title: "Are you sure you want to delete this room?",
            confirmAction: {
                if let roomToDelete = roomToDelete {
                    roomDetailViewModel.delete(roomToDelete)
                }
            }
        )
    }
    
    var header: some View {
        VStack {
            Components.RoomProfile(room: room, vertical: true)
            Text("Type: \(room.type)")
                .font(.caption)
        }
    }
    
    var updateButton: some View {
        Button {
            room.name = roomDetailViewModel.modifiedName
            roomDetailViewModel.update(room)
            dismiss()
        } label: {
            Text("Save")
        }
    }
}



