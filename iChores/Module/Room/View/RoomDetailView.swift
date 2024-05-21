import SwiftUI

struct RoomDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State var roomViewModel: RoomViewModel
    
    @State private var showingDeleteAlert: Bool = false
    @State private var roomToDelete: Room?
    
    let room: Room
    
    private func deleteRoom(room: Room) {
        do {
            try roomViewModel.deleteRoom(room, context: moc)
            dismiss()
        } catch {
            print("Error while deleting user: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        VStack {
            header
            
            DividerSpacer(height: 40)
            
            if roomViewModel.isEditingRoom {
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
            RoomButtons(roomViewModel: roomViewModel, room: room).cancelButton
            
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
    // MARK: - roomDetail
    var roomDetail: some View {
        UsersAndTasks(room: room)
        .toolbar {
            Button("Edit") {
                roomViewModel.startEdition(room: room)
            }
        }
    }
    
    // MARK: - roomEdition
    var roomEdition: some View {
        ScrollView {
            TextField("Room's name", text: $roomViewModel.modifiedName)
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
    
    // MARK: - Header
    var header: some View {
        VStack {
            RoomProfile(room: room, vertical: true)
            Text("Type: \(room.type)")
                .font(.caption)
        }
    }
    
    // MARK: - Update Button
    var updateButton: some View {
        Button {
            do {
                room.name = roomViewModel.modifiedName
                try roomViewModel.updateRoom(context: moc)
            } catch {
                print("Error while editing: \(error)")
            }
            dismiss()
        } label: {
            Text("Save")
        }
    }
}



