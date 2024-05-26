import SwiftUI

struct RoomDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var roomCoreDataHelper: RoomCoreDataHelper
    @State var roomDetailViewModel: RoomDetailViewModel
    
    @State private var showingDeleteAlert: Bool = false
    @State private var roomToDelete: Room?
    
    let room: Room
    
    private func deleteRoom(room: Room) {
        do {
            try roomDetailViewModel.delete(room)
            dismiss()
        } catch {
            print("Error while deleting user: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        VStack {
            header
            
            DividerSpacer(height: 40)
            
            if roomDetailViewModel.isEditingRoom {
                roomEdition
            } else {
                roomDetail
            }
        }
        .padding()
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
                roomDetailViewModel.edit(room: room)
            }
        }
    }
    
    var roomEdition: some View {
        ScrollView {
            TextField("Room's name", text: $roomCoreDataHelper.modifiedName)
                .textFieldStyle()
            
            DividerSpacer(height: 40)

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
                    deleteRoom(room: roomToDelete)
                }
            }
        )
    }
    
    var header: some View {
        VStack {
            RoomProfile(room: room, vertical: true)
            Text("Type: \(room.type)")
                .font(.caption)
        }
    }
    
    var updateButton: some View {
        Button {
            do {
                room.name = roomCoreDataHelper.modifiedName
                try roomDetailViewModel.update()
            } catch {
                print("Error while editing: \(error)")
            }
            dismiss()
        } label: {
            Text("Save")
        }
    }
}



