//
//  UserDetailView.swift
//  iChores
//
//  Created by Carolane Lefebvre on 28/12/2023.
//

import SwiftUI

struct UserDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State var userViewModel: UserViewModel
    
    @State private var showingDeleteAlert = false
    @State private var userToDelete: User?
    
    let user: User
    
    var body: some View {
        VStack {
            UserProfileImage(user: user)
            
            if userViewModel.isEditing {
                userEdition
            } else {
                userDetail
            }
        }
    }
}

extension UserDetailView {
    var userEdition: some View {
        VStack {
            TextField("Name", text: $userViewModel.modifiedName)
                .textFieldStyle()
            
            Spacer()
                .frame(height: 100)
            
            HStack {
                Button {
                    do {
                        try userViewModel.delete(user, context: moc)
                    } catch {
                        print("Error while deleting: \(error.localizedDescription)")
                    }
                } label: {
                    DeleteButton()
                }

                Button {
                    do {
                        user.name = userViewModel.modifiedName
                        try userViewModel.updateUser(context: moc)
                    } catch {
                        // TODO: turn into alert
                        print("Error while editing: \(error)")
                    }
                    dismiss()
                } label: {
                    Text("Save")
                        .foregroundStyle(.white)
                }
                .disabled(!userViewModel.isValidName(userViewModel.modifiedName))
                .primaryButtonStyle(isEnabled: userViewModel.isValidName(userViewModel.modifiedName))
            }
        }
        .alert("Are you sure you want to delete this user?", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive) {
                if let userToDelete = userToDelete {
                    do {
                        try userViewModel.delete(userToDelete, context: moc)
                    } catch {
                        print("Error while deleting user: \(error.localizedDescription)")
                    }
                }
            }
            
            Button("Cancel", role: .cancel) {}
        }
    }
    
    var userDetail: some View {
        VStack {
            Text(user.wrappedUserName)
            ForEach(user.userRoomArray, id: \.self) { room in
                Text("\(room.wrappedRoomName)")
            }
        }
        .toolbar {
            Button("Edit") {
                userViewModel.startEdition(user: user)
            }
        }
    }
}


