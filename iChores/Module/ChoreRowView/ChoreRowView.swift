import SwiftUI

struct ChoreRowView: View {
    let chore: Chore
    var choreRowViewModel = ChoreRowViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: chore.isDone ? "checkmark.square" : "square")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color("AppPrimaryColor"))
                
                Text(chore.title)
                    .font(.title3)
                    .foregroundStyle(Color("AppPrimaryColor"))
            }
                
            NavigationLink {
                ChoreRoomAssignView()
            } label: {
                if let room = chore.choreToRoom {
                    Components.RoomProfile(room: room, vertical: false).choreRoomImage
                        .primaryTag()
                } else {
                    Text("Tap to assign a room")
                        .primaryTag()
                }
            }
            
            NavigationLink {
                ChoreUserAssignView()
            } label: {
                if let user = chore.choreToUser {
                    Components.UserProfile(user: user, vertical: false).choreProfileUser
                        .secondaryTag()
                } else {
                    Text("Tap to assign a user")
                        .secondaryTag()
                }
            }
        }
        .homeBorder()
        .padding(.horizontal)
    }
}

