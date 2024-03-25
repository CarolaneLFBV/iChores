import SwiftUI

struct RoomDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State var roomViewModel: RoomViewModel
    
    let room: Room
    
    var body: some View {
        VStack {
            Spacer()
            
            roomHeader
            
            Spacer()
            
            roomInformations
            
            Spacer()
            
        }
    }
}

extension RoomDetailView {
    var roomHeader: some View {
        VStack {
            RoomImage(room: room)
            
            Text(room.wrappedRoomName)
                .font(.title)
        }
    }
    
    var roomInformations: some View {
        VStack {
            Text("Room's type: \(room.wrappedRoomType)")
                .textFieldStyle()
            Text("Belongs to: \(room.roomToUser?.wrappedUserName ?? "None")")
                .textFieldStyle()
        }
    }
}
