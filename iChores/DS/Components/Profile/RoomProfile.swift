import SwiftUI

extension Components {
    struct RoomProfile: View {
        let room: Room
        let vertical: Bool
    }
}


extension Components.RoomProfile {
    var body: some View {
        Group {
            if vertical {
                VStack {
                    Components.RoomImage(room: room, size: vertical ? 95 : 40)
                    profileRoomText
                }
            } else {
                HStack {
                    Components.RoomImage(room: room, size: vertical ? 95 : 40)
                    profileRoomText
                }
            }
        }
    }
    
    private var profileRoomText: some View {
        Text(room.name)
            .font(.title3)
    }
    
    var choreRoomImage: some View {
        HStack(spacing: 0) {
            Image(systemName: room.roomImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .padding(.all, 4)
                .padding(.trailing, 4)
            Text(room.name)
        }
    }
}
