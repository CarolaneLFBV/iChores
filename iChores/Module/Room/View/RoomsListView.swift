//
//  RoomsListView.swift
//  iChores
//
//  Created by Carolane Lefebvre on 29/12/2023.
//

import SwiftUI

struct RoomsListView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var roomViewModel = RoomViewModel()
    @State private var showingAddRoom: Bool = false
    
    var body: some View {
        roomList
            .task {
                try? roomViewModel.fetchRooms(context: moc)
            }
    }
}

extension RoomsListView {
    
    var roomList: some View {
        VStack {
            if roomViewModel.rooms.isEmpty {
                NoRoomView()
            } else {
                roomLazyGridView
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    showingAddRoom.toggle()
                } label: {
                    Label("Add user", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddRoom, content: {
            AddRoomView(roomViewModel: roomViewModel)
        })
    }
    
    var roomLazyGridView: some View {
        ScrollView {
            ForEach(roomViewModel.rooms, id: \.self) { room in
                NavigationLink(destination: RoomDetailView(roomViewModel: roomViewModel, room: room)) {
                    Text(room.wrappedRoomName)
                }
            }
        }
    }
}

#Preview {
    RoomsListView()
}
