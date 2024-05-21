import SwiftUI
import CoreData

struct UsersListView: View {
    @Environment(\.managedObjectContext) var moc
    @State var userViewModel: UserViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        usersList
            .task {
                if userViewModel.users.isEmpty {
                    try? userViewModel.fetchUsers(context: moc)
                }
            }
    }
}

extension UsersListView {
    // MARK: - usersList
    var usersList: some View {
        VStack {
            if userViewModel.users.isEmpty {
                NoUserView()
            } else {
                lazyGridView
            }
        }
        .navigationTitle(userViewModel.users.count > 0 ? "Users" : "")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationLink(destination: AddUserView(userViewModel: userViewModel), label: {
                    Label("Add User", systemImage: "plus")
                })
            }
        }
    }
    
    // MARK: - lazyGridView
    var lazyGridView: some View {
        ScrollView {
            LazyVGrid(columns: columns, content: {
                ForEach(userViewModel.users, id: \.self) { user in
                    NavigationLink(destination: UserDetailView(userViewModel: userViewModel, user: user)) {
                        UserProfile(user: user)
                        .overlay(alignment: .topTrailing) {
                            UserButtons(moc: _moc, userViewModel: userViewModel, user: user).deleteUserList
                        }
                    }
                }
            })
        }
        //TODO: - Find a fix 
//        .toolbar {
//            ToolbarItem(placement: .topBarTrailing) {
//                UserButtons(userViewModel: userViewModel, user: user).editingUserList
//            }
//        }
    }
}
