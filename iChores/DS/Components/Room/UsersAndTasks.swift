import SwiftUI

struct UsersAndTasks: View {
    let room: Room
    
    var body: some View {
        VStack {
            Text("Belongs to: \(room.roomToUser.name)")
                .textFieldStyle()
            
            DividerSpacer(height: 40).spacer
            
            VStack(alignment: .leading) {
                Text("Chores")
                    .font(.headline)
                
                ScrollView(.vertical) {
                    ForEach(room.roomChoreArray, id: \.self) { chore in
                        HStack {
                            Text(chore.title)
                            Spacer()
                            Text("\(chore.choreToRoom.name)")
                        }
                    }
                }
                .homeBorder()
            }
        }
    }
}
