import SwiftUI

struct RoomsAndTasks: View {
    let user: User
    
    var body: some View {
        VStack {
            if user.userRoomArray.isEmpty {
                noRoomData
            } else {
                userRoomArray
            }
            
            Components.DividerSpacer(height: 40)

            if user.userChoreArray.isEmpty {
                noChoreData
            } else {
                userChoreArray
            }
            
        }
    }
}

extension RoomsAndTasks {
    var userChoreTitle: some View {
        Text("\(user.name)'s tasks")
            .font(.headline)
    }
    
    var userRoomTitle: some View {
        Text("Rooms owned by \(user.name)")
            .font(.headline)
    }
    
    var noChoreData: some View {
        VStack(alignment: .leading) {
            userChoreTitle
            Components.NoDataSelected(dataType: .chore)
                .homeBorder()
        }
    }
    
    var noRoomData: some View {
        VStack(alignment: .leading) {
            userRoomTitle
            Components.NoDataSelected(dataType: .room)
                .homeBorder()
        }
    }

    var userChoreArray: some View {
        VStack(alignment: .leading) {
            userChoreTitle
            ScrollView(.vertical) {
                ForEach(user.userChoreArray, id: \.self) { chore in
                    Text("\(chore.title)")
                }
            }
            .homeBorder()
        }
    }
    
    var userRoomArray: some View {
        VStack(alignment: .leading) {
            userRoomTitle
            
            ScrollView(.horizontal) {
                ForEach(user.userRoomArray, id: \.self) { room in
                    Components.RoomProfile(room: room, vertical: true)
                }
            }
        }
    }
}

