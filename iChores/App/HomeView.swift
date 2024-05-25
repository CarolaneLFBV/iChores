import SwiftUI

struct HomeView: View {
    @State var userViewModel: UserViewModel
    @State var roomViewModel: RoomViewModel
    @State var choreViewModel: ChoreViewModel
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var moc
    
    // @State private var isShowingChores = false
    
    var body: some View {
        ZStack {
            ScrollView {
                userSection
            }
//            .toolbar {
//                ToolbarItem(placement: .topBarLeading, content: {
//                    Button("Chores") {
//                        isShowingChores.toggle()
//                    }
//                })
//            }
                        
            contextMenuButton
        }
        .task {
            try? userViewModel.fetchUsers()
            try? roomViewModel.fetchRooms()
            try? choreViewModel.fetchChores()
        }
        .navigationTitle("Home")
    }
}


extension HomeView {
    // MARK: - User Section
    var userSection: some View {
        VStack {
            ForEach(userViewModel.users, id: \.self) { user in
                VStack(alignment: .leading) {
                    UserProfile(user: user).horizontal
                    
                    ForEach(user.userChoreArray, id: \.self) { chore in
                        ChoreRowView(chore: chore, choreViewModel: choreViewModel)
                    }
                }
                .homeBorder()
            }
        }
        .padding()
    }
    
    // MARK: - Context Menu Btn
    var contextMenuButton: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Menu {
                    NavigationLink(destination: AddUserView(userViewModel: userViewModel), label: {
                        Label("Create User", systemImage: "person.fill.badge.plus")
                    })
                    NavigationLink(destination: AddRoomView(roomViewModel: roomViewModel, userViewModel: userViewModel), label: {
                        Label("Create Room", systemImage: "square.split.bottomrightquarter.fill")
                    })
                    if !userViewModel.users.isEmpty && !roomViewModel.rooms.isEmpty {
                        NavigationLink(destination: AddChoreView(choreViewModel: choreViewModel, roomViewModel: roomViewModel, userViewModel: userViewModel), label: {
                            Label("Create Task", systemImage: "circle.inset.filled")
                        })
                    }
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(colorScheme == .dark ? .black : .white)
                }
                .buttonStyle(ContextMenuButton())
            }
        }
    }
}


