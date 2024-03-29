import SwiftUI

struct UserDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    @State var userViewModel: UserViewModel
    
    @State private var showingDeleteAlert = false
    @State private var userToDelete: User?
    
    let user: User
    
    var body: some View {
        VStack {
            UserImage(user: user)
            
            if userViewModel.isEditingUser {
                userEdition
            } else {
                userDetail
            }
        }
        .onAppear {
            print(user.userTaskArray)
        }
    }
}

extension UserDetailView {
    // MARK: - userEdition
    var userEdition: some View {
        VStack {
            HStack {
                Spacer()
                
                TextField("Name", text: $userViewModel.modifiedName)
                    .textFieldStyle()
                
                Spacer()
            }
                        
            HStack {
                SecondaryButton()
                
                Button {
                    showingDeleteAlert = true
                    userToDelete = user
                } label: {
                    Text("Delete")
                        .padding()
                }
                .deleteButtonStyle()
            }
        }
        .toolbar {
            Button {
                do {
                    user.name = userViewModel.modifiedName
                    try userViewModel.updateUser(context: moc)
                } catch {
                    print("Error while editing: \(error)")
                }
                dismiss()
            } label: {
                Text("Save")
            }
            .disabled(!userViewModel.isValidName(userViewModel.modifiedName))
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
                dismiss()
            }
            
            Button("Cancel", role: .cancel) {}
        }
    }
    
    // MARK: - userDetail
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


