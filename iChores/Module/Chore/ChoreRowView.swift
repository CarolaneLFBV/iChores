import SwiftUI

struct ChoreRowView: View {
    let chore: Chore
    var editChoreViewModel = EditChoreViewModel()
    
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
            
            Spacer()
            
            if let room = chore.choreToRoom {
                Components.RoomProfile(room: room, vertical: false).choreRoomImage
                    .primaryTag()
            } else {
                HStack(spacing: 0) {
                    Text("No Room Assigned")
                        .primaryTag()
                    
                    Spacer()
                    
                    Button {
                        //
                    } label: {
                        Label("Assign", systemImage: "plus")
                    }
                    .buttonStyle(.bordered)
                }
            }
            
            if let user = chore.choreToUser {
                Components.UserProfile(user: user, vertical: false).choreProfileUser  .secondaryTag()
            } else {
                HStack {
                    Text("No User Assigned")
                        .secondaryTag()
                    
                    Spacer()
                    
                    Button {
                        //
                    } label: {
                        Label("Assign", systemImage: "plus")
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
        .homeBorder()
        .padding(.horizontal)
    }
}

