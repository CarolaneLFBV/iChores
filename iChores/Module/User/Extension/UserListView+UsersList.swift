//
//  UserListView+UsersList.swift
//  iChores
//
//  Created by Carolane Lefebvre on 30/12/2023.
//

import SwiftUI

extension UsersListView {
    var usersList: some View {
        VStack {
            if users.isEmpty {
                NoUserView()
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, content: {
                        ForEach(users, id: \.self) { user in
                            NavigationLink(destination: UserDetailView(user: user)) {
                                VStack {
                                    UserProfileImage(user: user)
                                    Text(user.wrappedUserName)
                                        .foregroundStyle(.black)
                                }
                            }
                            .overlay(
                                userViewModel.isEditing ? Button {
                                    deleteUser(user)
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.red)
                                        .background(Circle().foregroundColor(.white))
                                        .padding(4)
                                } : nil,
                                alignment: .topTrailing
                            )
                        }
                    })
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    showingAddUser.toggle()
                } label: {
                    Label("Add user", systemImage: "plus")
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    userViewModel.isEditing.toggle()
                } label: {
                    Label("Edit", systemImage: userViewModel.isEditing ? "checkmark" : "square.and.pencil")
                }
            }
        }
        .sheet(isPresented: $showingAddUser) {
            AddUserView()
        }
        .onAppear {
            do {
                try userViewModel.fetchUsers(context: moc)
            } catch {
                // TODO: turn into alert
                print("Error while fetching users: \(error.localizedDescription)")
            }
        }
    }
    
    private func deleteUser(_ user: User) {
        guard let index = users.firstIndex(of: user) else {
            print("User not found in the list.")
            return
        }

        do {
            try userViewModel.deleteUser(at: IndexSet([index]), context: moc)
        } catch {
            print("Error while deleting: \(error.localizedDescription)")
        }
    }
}
