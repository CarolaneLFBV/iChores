import SwiftUI
import CoreData

struct UsersListView: View {
    @Environment(\.managedObjectContext) var moc
    @State var userViewModel = UserViewModel()
    
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
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationLink(destination: AddUserView(userViewModel: userViewModel), label: {
                    Label("Add User", systemImage: "plus")
                })
            }
            
            if userViewModel.users.count > 0 {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        userViewModel.isEditing.toggle()
                    } label: {
                        Label("Edit", systemImage: userViewModel.isEditing ? "checkmark" : "pencil")
                    }
                }
            }
        }
    }
    
    // MARK: - lazyGridView
    var lazyGridView: some View {
        ScrollView {
            LazyVGrid(columns: columns, content: {
                ForEach(userViewModel.users, id: \.self) { user in
                    NavigationLink(destination: UserDetailView(userViewModel: userViewModel, user: user)) {
                        VStack {
                            UserImage(user: user)
                            Text(user.wrappedUserName)
                        }
                        .onAppear {
                            print(user.userRoomArray)
                        }
                        .overlay(alignment: .topTrailing) {
                            if userViewModel.isEditing {
                                Button {
                                    do {
                                        try userViewModel.delete(user, context: moc)
                                    } catch {
                                        // TODO: Turn into alert
                                        print("Error while deleting user: \(error.localizedDescription)")
                                    }
                                } label: {
                                    DeleteButton()
                                }
                            }
                        }
                        .padding()
                    }
                }
            })
        }
    }
}
