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
                NavigationLink(destination: AddRoomView(roomViewModel: roomViewModel), label: {
                    Label("Add Room", systemImage: "plus")
                })
            }
        }
    }
    
    var roomLazyGridView: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(roomViewModel.rooms, id: \.self) { room in
                    NavigationLink(destination: RoomDetailView(roomViewModel: roomViewModel, room: room)) {
                        VStack {
                            Image(systemName: room.roomImageName)
                                .resizable()
                                .frame(width: 50, height: 30)
                            Text(room.wrappedRoomName)
                        }
                        .padding()
                        .foregroundStyle(.black)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .gray, radius: 3, x: 5, y: 5)
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    RoomsListView()
}
