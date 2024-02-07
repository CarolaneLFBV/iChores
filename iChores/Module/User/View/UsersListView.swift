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
    
    @State private var fetchError: Error?
    @State private var showErrorAlert: Bool = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        usersList
            .task {
                do {
                    try userViewModel.fetchUsers(context: moc)
                } catch {
                    fetchError = error
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
                userListView
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
    }
    
    var userListView: some View {
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
        .alert("Erreur de chargement", isPresented: $showErrorAlert) {
              Button("OK", role: .cancel) { }
          } message: {
              Text(fetchError?.localizedDescription ?? "Une erreur inconnue est survenue.")
          }
    }
}


#Preview {
    UsersListView()
}
