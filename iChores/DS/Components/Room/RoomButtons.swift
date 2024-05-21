import SwiftUI

struct RoomButtons: View {
    @Environment(\.managedObjectContext) var moc
    @State var roomViewModel: RoomViewModel
    let room: Room
    
    var body: some View {
        deleteButton
    }
    
    var deleteButton: some View {
        Button {
            do {
                try roomViewModel.deleteRoom(room, context: moc)
            } catch {
                print("Error while deleting: \(error.localizedDescription)")
            }
        } label: {
            Text("Delete")
                .padding()
        }
        .deleteButtonStyle()
    }
    
    var cancelButton: some View {
        Button {
            roomViewModel.isEditingRoomsList = false
            roomViewModel.isEditingRoom = false
        } label: {
            Text("Cancel")
                .padding()
        }
        .secondaryButtonStyle()
    }
    
    var deleteRoom: some View {
        VStack {
            if roomViewModel.isEditingRoomsList {
                Button {
                    do {
                        try roomViewModel.deleteRoom(room, context: moc)
                    } catch {
                        // TODO: Turn into alert
                        print("Error while deleting user: \(error.localizedDescription)")
                    }
                } label: {
                    ListDeleteButton()
                }
            }
        }
    }
    
}

