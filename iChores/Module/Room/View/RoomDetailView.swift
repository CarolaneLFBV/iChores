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
            Spacer()
            
            roomHeader
            Spacer()
            
            if roomViewModel.isEditingRoom {
                roomEdition
            } else {
                roomDetail
            }
            
            Spacer()
        }
    }
}

extension RoomDetailView {
    var roomHeader: some View {
        VStack {
            RoomImage(room: room)
            
            VStack {
                Text(room.name)
                    .font(.title)
                Text("Type: \(room.type)")
                    .font(.caption)
            }
        }
    }
    
    // MARK: - roomInformations
    var roomInformations: some View {
        Text("Belongs to: \(room.roomToUser.name)")
            .textFieldStyle()
        
    }
    
    // MARK: - roomDetail
    var roomDetail: some View {
        VStack {
            roomInformations
            roomTasks
        }
        .toolbar {
            Button("Edit") {
                roomViewModel.startEdition(room: room)
            }
        }
    }
    
    // MARK: - roomTasks
    var roomTasks: some View {
        VStack {
            ForEach(room.roomChoreArray, id: \.self) { chore in
                Text(chore.title)
            }
        }
    }
    
    // MARK: - roomEdition
    var roomEdition: some View {
        VStack {
            TextField("Room's name", text: $roomViewModel.modifiedName)
                .textFieldStyle()
            
            Spacer()
                .frame(height: 100)
            
            HStack {
                SecondaryButton()
                
                Button {
                    do {
                        try roomViewModel.delete(room, context: moc)
                    } catch {
                        print("Error while deleting: \(error.localizedDescription)")
                    }
                } label: {
                    Text("Delete")
                        .padding()
                }
                .deleteButtonStyle()
            }
        }
        .toolbar {
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
        .alert("Are you sure you want to delete this user?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                if let roomToDelete = roomToDelete {
                    do {
                        try roomViewModel.delete(roomToDelete, context: moc)
                    } catch {
                        print("Error while deleting user: \(error.localizedDescription)")
                    }
                }
            }
            
            Button("Cancel", role: .cancel) {}
        }
    }
}
