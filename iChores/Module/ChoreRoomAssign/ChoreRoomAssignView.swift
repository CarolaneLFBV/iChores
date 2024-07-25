import SwiftUI

struct ChoreRoomAssignView: View {
    @State var choreRoomAssignViewModel = ChoreRoomAssignViewModel()
    @State private var showingAddRoom: Bool = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ZStack {
            Color("AppBackgroundColor")
                .ignoresSafeArea()
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(choreRoomAssignViewModel.rooms, id: \.idRoom) { room in
                        Components.RoomProfile(room: room, vertical: true)
                    }
                }
            }
        }
        .task {
            choreRoomAssignViewModel.loadData()
        }
    }
}
