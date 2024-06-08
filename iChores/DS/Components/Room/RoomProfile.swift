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
                    profileImage
                    profileText
                }
            } else {
                HStack {
                    profileImage
                    profileText
                }
            }
        }
    }
    
    private var profileImage: some View {
        Image(systemName: room.roomImageName)
            .resizable()
            .padding()
            .imageSizeStyle(width: vertical ? 95 : 40, height: vertical ? 95 : 40, contentMode: .fit)
            .imageBorderStyle()
    }
    
    private var profileText: some View {
        Text(room.name)
            .font(.title3)
    }
}
