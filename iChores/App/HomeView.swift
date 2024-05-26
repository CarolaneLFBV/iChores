import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme

    @State var userCoreDataHelper: UserCoreDataHelper
    @State var roomCoreDataHelper: RoomCoreDataHelper
    @State var choreCoreDataHelper: ChoreCoreDataHelper
    
    @State var addUserViewModel: AddUserViewModel
    @State var addRoomViewModel: AddRoomViewModel
    @State var addChoreViewModel: AddChoreViewModel
    @State var editChoreViewModel: EditChoreViewModel

    var body: some View {
        ZStack {
            ScrollView {
                userSection
            }
            contextMenuButton
        }
        .task {
            try? userCoreDataHelper.fetch()
            try? roomCoreDataHelper.fetch()
            try? choreCoreDataHelper.fetch()
        }
        .navigationTitle("Home")
    }
}


extension HomeView {
    private var userSection: some View {
        VStack {
            ForEach(userCoreDataHelper.users, id: \.idUser) { user in
                VStack(alignment: .leading) {
                    UserProfile(user: user).horizontal
                    
                    ForEach(user.userChoreArray, id: \.self) { chore in
                        ChoreRowView(chore: chore, editChoreViewModel: editChoreViewModel)
                    }
                }
                .homeBorder()
            }
        }
        .padding()
    }
    
    private var contextMenuButton: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Menu {
                    NavigationLink(destination: AddUserView(addUserViewModel: addUserViewModel), label: {
                        Label("Create User", systemImage: "person.fill.badge.plus")
                    })
                    NavigationLink(destination: AddRoomView(userCoreDataHelper: userCoreDataHelper, addRoomViewModel: addRoomViewModel), label: {
                        Label("Create Room", systemImage: "square.split.bottomrightquarter.fill")
                    })
                    if !userCoreDataHelper.users.isEmpty && !roomCoreDataHelper.rooms.isEmpty {
                        NavigationLink(destination: AddChoreView(userCoreDataHelper: userCoreDataHelper, roomCoreDataHelper: roomCoreDataHelper, addChoreViewModel: addChoreViewModel), label: {
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


