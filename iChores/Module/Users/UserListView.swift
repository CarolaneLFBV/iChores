import SwiftUI
import CoreData

struct UserListView: View {
    @State var userListViewModel = UserListViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ZStack {
            Color("AppBackgroundColor")
                .ignoresSafeArea()

            userList
                .task {
                    userListViewModel.loadData()
                }
        }
    }
}

extension UserListView {
    private var userList: some View {
        VStack {
            if userListViewModel.users.isEmpty {
                Components.NoDataFoundView(dataType: .user)
            } else {
                lazyGridView
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: AddUserView()) {
                    Label("Add User", systemImage: "plus")
                }
            }
        }
    }
    
    private var lazyGridView: some View {
        ScrollView {
            LazyVGrid(columns: columns, content: {
                ForEach(userListViewModel.users, id: \.idUser) { user in
                    NavigationLink(destination: UserDetailView(user: user)) {
                        Components.UserProfile(user: user, vertical: true)
                            .padding()
                            .overlay(alignment: .topTrailing, content: {
                                if userListViewModel.isEditingUsersList {
                                    Button {
                                        userListViewModel.delete(user)
                                    } label: {
                                        Components.ListDeleteButton()
                                    }
                                }
                            })
                    }
                }
            })
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    userListViewModel.isEditingUsersList.toggle()
                } label: {
                    Label("Edit", systemImage: userListViewModel.isEditingUsersList ? "checkmark" : "pencil")
                }
            }
        }
    }
}
