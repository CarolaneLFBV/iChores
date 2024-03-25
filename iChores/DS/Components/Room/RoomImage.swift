import SwiftUI

struct RoomImage: View {
    let room: Room
    
    var body: some View {
        Image(systemName: room.roomImageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .imageStyle()
    }
}
