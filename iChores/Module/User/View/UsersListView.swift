import SwiftUI
import CoreData

struct UsersListView: View {
    @State var userViewModel: UserViewModel
    @State var addUserViewModel: AddUserViewModel

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ScrollView {
            if userViewModel.users.isEmpty {
                NoUserView()
            } else {
                lazyGridView
            }
        }
        .task {
            if userViewModel.users.isEmpty {
                try? userViewModel.fetchUsers()
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationLink(destination: AddUserView(addUserViewModel: addUserViewModel)) {
                    Label("Add User", systemImage: "plus")
                }
            }
        }
    }
}

extension UsersListView {
    private var lazyGridView: some View {
        ScrollView {
            LazyVGrid(columns: columns, content: {
                ForEach(userViewModel.users, id: \.idUser) { user in
                    NavigationLink(destination: UserDetailView(userViewModel: userViewModel, user: user)) {
                        UserProfile(user: user)
                            .padding()
                            .overlay(alignment: .topTrailing, content: {
                                if userViewModel.isEditingUsersList {
                                    Button {
                                        do {
                                            try userViewModel.delete(user)
                                        } catch {
                                            // TODO: Turn into alert
                                            print("Error while deleting user: \(error.localizedDescription)")
                                        }
                                    } label: {
                                        ListDeleteButton()
                                    }
                                }
                            })
                    }
                }
            })
        }
        .navigationTitle(userViewModel.users.count == 1 ? "User" : "Users")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    userViewModel.isEditingUsersList.toggle()
                } label: {
                    Label("Edit", systemImage: userViewModel.isEditingUsersList ? "checkmark" : "pencil")
                }
            }
        }
    }
}
