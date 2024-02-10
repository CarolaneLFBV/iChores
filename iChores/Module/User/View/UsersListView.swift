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
        .onAppear() {
            try? userViewModel.fetchUsers(context: moc)
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
                    Label("Edit", systemImage: userViewModel.isEditing ? "checkmark" : "pencil")
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
                    NavigationLink(destination: UserDetailView(user: user)) {
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
                                    print("Error while deleting user: \(error.localizedDescription)")
                                }
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.red)
                                    .background(Circle().foregroundColor(.white))
                                    .padding(4)
                            }
                        }
                    }
                }
            })
        }
    }
}


#Preview {
    UsersListView()
}
