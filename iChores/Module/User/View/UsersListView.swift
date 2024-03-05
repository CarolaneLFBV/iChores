//
//  UsersListView.swift
//  iChores
//
//  Created by Carolane Lefebvre on 29/12/2023.
//

import SwiftUI
import CoreData

struct UsersListView: View {
    @Environment(\.managedObjectContext) var moc
        
    @State var showingAddUser = false
    @State var showingDeleteAlert = false
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
    var usersList: some View {
        VStack {
            if userViewModel.users.isEmpty {
                NoUserView()
            } else {
                userLazyGridView
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
        .sheet(isPresented: $showingAddUser) {
            AddUserView(userViewModel: userViewModel)
        }
    }
    
    var userLazyGridView: some View {
        ScrollView {
            LazyVGrid(columns: columns, content: {
                ForEach(userViewModel.users, id: \.self) { user in
                    NavigationLink(destination: UserDetailView(userViewModel: userViewModel, user: user)) {
                        VStack {
                            UserProfileImage(user: user)
                            Text(user.wrappedUserName)
                                .foregroundStyle(.black)
                        }
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
                }
            })
        }
    }
}
