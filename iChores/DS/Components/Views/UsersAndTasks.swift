import SwiftUI

struct UsersAndTasks: View {
    let room: Room
    
    var body: some View {
        VStack {
            Text("Belongs to: \(room.roomToUser.name)")
                .textFieldStyle()
            
            Components.DividerSpacer(height: 40)
            
            VStack(alignment: .leading) {
                Text("Chores")
                    .font(.headline)
                
                VStack {
                    if room.roomChoreArray.isEmpty {
                        Components.NoDataSelected(dataType: .chore)
                    } else {
                        ScrollView(.vertical) {
                            ForEach(room.roomChoreArray, id: \.self) { chore in
                                HStack {
                                    Text(chore.title)
                                    Spacer()
                                    Text("\(chore.choreToRoom?.name ?? "N/A")")
                                }
                            }
                        }
                    }
                }
                .homeBorder()
            }
        }
    }
}
