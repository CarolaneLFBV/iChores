import SwiftUI

struct RoomButtons: View {
    @Environment(\.managedObjectContext) var moc
    @State var roomViewModel: RoomViewModel
    let room: Room
    
    var body: some View {
        cancelButton
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

