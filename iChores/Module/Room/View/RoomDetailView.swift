import SwiftUI

struct RoomDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State var roomViewModel: RoomViewModel
    
    @State private var showingDeleteAlert: Bool = false
    @State private var roomToDelete: Room?
    
    let room: Room
    
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
            
            HStack {
                RoomButtons(roomViewModel: roomViewModel, room: room).cancelButton
                RoomButtons(roomViewModel: roomViewModel, room: room).deleteButton
            }
        }
        .toolbar {
            updateButton
        }
        .alert("Are you sure you want to delete this user?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                if let roomToDelete = roomToDelete {
                    do {
                        try roomViewModel.deleteRoom(roomToDelete, context: moc)
                    } catch {
                        print("Error while deleting user: \(error.localizedDescription)")
                    }
                }
            }
            
            Button("Cancel", role: .cancel) {}
        }
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



