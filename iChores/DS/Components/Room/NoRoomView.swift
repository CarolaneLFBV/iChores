import SwiftUI

struct NoRoomView: View {
    var body: some View {
        VStack {
            Image(systemName: "square.split.bottomrightquarter")
                .font(.title)
                .foregroundColor(.gray.opacity(0.7))
            
            DividerSpacer(height: 8)
            
            Text("No Rooms found")
                .font(.title2)
                .bold()
            
            Text("Create a new room with the + button")
                .foregroundStyle(.gray)
        }
    }
}

