import SwiftUI

struct RoomsListView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var roomViewModel = RoomViewModel()
    @State private var userViewModel = UserViewModel()
    @State private var showingAddRoom: Bool = false
    
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        roomList
            .task {
                try? roomViewModel.fetchRooms(context: moc)
            }
    }
}

extension RoomsListView {
    // MARK: - roomList
    var roomList: some View {
        VStack {
            if roomViewModel.rooms.isEmpty {
                NoRoomView()
            } else {
                lazyGridView
            }
        }
        .navigationTitle(roomViewModel.rooms.count > 0 ? "Rooms" : "")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationLink(destination: AddRoomView(roomViewModel: roomViewModel, userViewModel: userViewModel), label: {
                    Label("Add Room", systemImage: "plus")
                })
            }
        }
    }
    
    // MARK: - lazyGridView
    var lazyGridView: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(roomViewModel.rooms, id: \.self) { room in
                    NavigationLink(destination: RoomDetailView(roomViewModel: roomViewModel, room: room)) {
                        VStack {
                            RoomImage(room: room)
                            Text(room.wrappedRoomName)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

