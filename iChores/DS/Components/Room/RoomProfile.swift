import SwiftUI

struct RoomProfile: View {
    let room: Room
    let vertical: Bool
    
    var body: some View {
        VStack {
            if vertical {
                verticalProfile
            } else {
                horizontalProfile
            }
        }
    }
    
    var verticalProfile: some View {
        VStack {
            Image(systemName: room.roomImageName)
                .resizable()
                .padding()
                .imageSizeStyle(width: 95, height: 95, contentMode: .fit)
                .imageBorderStyle()

            
            Text(room.name)
                .font(.title3)
        }
    }
    
    var horizontalProfile: some View {
        HStack {
            Image(systemName: room.roomImageName)
                .resizable()
                .imageSizeStyle(width: 40, height: 40, contentMode: .fit)

            
            Text(room.name)
                .font(.title3)
        }
    }
}
