import SwiftUI

struct RoomListView: View {
    @State var userCoreDataHelper: UserCoreDataHelper
    @State var roomCoreDataHelper: RoomCoreDataHelper

    @State var roomListViewModel: RoomListViewModel
    @State var roomDetailViewModel: RoomDetailViewModel
    @State var addRoomViewModel: AddRoomViewModel

    @State private var showingAddRoom: Bool = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        roomList
            .task {
                try? roomCoreDataHelper.fetch()
            }
    }
}

extension RoomListView {
    var roomList: some View {
        VStack {
            if roomCoreDataHelper.rooms.isEmpty {
                NoRoomView()
            } else {
                lazyGridView
            }
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationLink(destination: AddRoomView( userCoreDataHelper:  userCoreDataHelper, addRoomViewModel: addRoomViewModel), label: {
                    Label("Add Room", systemImage: "plus")
                })
            }
        }
    }
    
    var lazyGridView: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(roomCoreDataHelper.rooms, id: \.idRoom) { room in
                    NavigationLink(destination: RoomDetailView(roomCoreDataHelper: roomCoreDataHelper, roomDetailViewModel: roomDetailViewModel, room: room)) {
                        RoomProfile(room: room, vertical: true)
                            .overlay(alignment: .topTrailing) {
                                if roomListViewModel.isEditingRoomsList {
                                    Button {
                                        do {
                                            try roomListViewModel.delete(room)
                                        } catch {
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
        .navigationTitle(roomCoreDataHelper.rooms.count > 0 ? "Rooms" : "")
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

