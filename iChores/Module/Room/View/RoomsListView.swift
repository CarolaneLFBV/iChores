import SwiftUI

struct RoomsListView: View {
    @Environment(\.managedObjectContext) var moc
    @State var roomViewModel: RoomViewModel
    @State  var userViewModel: UserViewModel
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
                            Text(room.name)
                        }
                        .overlay(alignment: .topTrailing) {
                            if roomViewModel.isEditingRoomsList {
                                Button {
                                    do {
                                        try roomViewModel.delete(room, context: moc)
                                    } catch {
                                        // TODO: Turn into alert
                                        print("Error while deleting user: \(error.localizedDescription)")
                                    }
                                } label: {
                                    ListDeleteButton()
                                }
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(roomViewModel.rooms.count > 0 ? "Rooms" : "")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    roomViewModel.isEditingRoomsList.toggle()
                } label: {
                    Label("Edit", systemImage: roomViewModel.isEditingRoomsList ? "checkmark" : "pencil")
                }
            }
        }
    }
}

