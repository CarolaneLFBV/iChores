import SwiftUI

struct RoomsAndTasks: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Rooms owned by \(user.name)")
                .font(.headline)
            
            ScrollView(.horizontal) {
                ForEach(user.userRoomArray, id: \.self) { room in
                    RoomProfile(room: room, vertical: true)
                }
            }
        }
        
        DividerSpacer(height: 40)
        
        VStack(alignment: .leading) {
            Text("\(user.name)'s tasks")
                .font(.headline)
            
            ScrollView(.vertical) {
                ForEach(user.userChoreArray, id: \.self) { chore in
                    Text("\(chore.title)")
                }
            }
            .homeBorder()
        }
    }
}
