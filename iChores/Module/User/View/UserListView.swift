import SwiftUI
import CoreData

struct UserListView: View {
    @State var userCoreDataHelper: UserCoreDataHelper
    @State var userListViewModel: UserListViewModel
    @State var addUserViewModel: AddUserViewModel
    @State var userDetailViewModel: UserDetailViewModel

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ScrollView {
            if userCoreDataHelper.users.isEmpty {
                NoUserView()
            } else {
                lazyGridView
            }
        }
        .task {
            try? userCoreDataHelper.fetch()
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

extension UserListView {
    private var lazyGridView: some View {
        ScrollView {
            LazyVGrid(columns: columns, content: {
                ForEach(userCoreDataHelper.users, id: \.idUser) { user in
                    NavigationLink(destination: UserDetailView(userCoreDataHelper: userCoreDataHelper, userDetailViewModel: userDetailViewModel, user: user)) {
                        UserProfile(user: user)
                            .padding()
                            .overlay(alignment: .topTrailing, content: {
                                if userListViewModel.isEditingUsersList {
                                    Button {
                                        do {
                                            try userListViewModel.delete(user)
                                        } catch {
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
        .navigationTitle(userCoreDataHelper.users.count == 1 ? "User" : "Users")
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
