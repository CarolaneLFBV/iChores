import SwiftUI

struct RoomProfile: View {
    let room: Room
    let vertical: Bool
    
    var body: some View {
        VStack {
            if vertical {
                VStack {
                    Image(systemName: room.roomImageName)
                        .resizable()
                        .imageSizeStyle(width: 65, height: 65, contentMode: .fit)
                        .imageBorderStyle()

                    
                    Text(room.name)
                        .font(.title3)
                }
            } else {
                HStack {
                    Image(systemName: room.roomImageName)
                        .resizable()
                        .imageSizeStyle(width: 40, height: 40, contentMode: .fit)

                    
                    Text(room.name)
                        .font(.title3)
                }
            }
        }
    }
    
//    var horizontal: some View {
//
//    }
}
