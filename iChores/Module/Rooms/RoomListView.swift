import SwiftUI

struct RoomListView: View {
    @State var roomListViewModel = RoomListViewModel()
    @State private var showingAddRoom: Bool = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        roomList
            .task {
                roomListViewModel.loadData()
            }
    }
}

extension RoomListView {
    var roomList: some View {
        VStack {
            if roomListViewModel.rooms.isEmpty {
                Components.NoDataFoundView(dataType: .room)
            } else {
                lazyGridView
            }
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationLink(destination: AddRoomView(), label: {
                    Label("Add Room", systemImage: "plus")
                })
            }
        }
    }
    
    var lazyGridView: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(roomListViewModel.rooms, id: \.idRoom) { room in
                    NavigationLink(destination: RoomDetailView(room: room)) {
                        RoomProfile(room: room, vertical: true)
                            .overlay(alignment: .topTrailing) {
                                if roomListViewModel.isEditingRoomsList {
                                    Button {
                                        roomListViewModel.delete(room)
                                    } label: {
                                        Components.ListDeleteButton()
                                    }
                                }
                            }
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    roomListViewModel.isEditingRoomsList.toggle()
                } label: {
                    Label("Edit", systemImage: roomListViewModel.isEditingRoomsList ? "checkmark" : "pencil")
                }
            }
        }
    }
}

