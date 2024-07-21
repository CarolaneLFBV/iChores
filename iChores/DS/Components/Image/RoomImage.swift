import SwiftUI

extension Components {
    struct RoomImage: View {
        let room: Room
        let size: CGFloat
    }
}

extension Components.RoomImage {
    var body: some View {
        Image(systemName: room.roomImageName)
            .resizable()
            .padding()
            .imageSizeStyle(width: size, height: size, contentMode: .fit)
            .imageBorderStyle()
    }
}
