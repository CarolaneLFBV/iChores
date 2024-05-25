import SwiftUI

struct UserDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State var userViewModel: UserViewModel
    
    @State private var showingDeleteAlert = false
    @State private var userToDelete: User?
    
    let user: User
    
    var body: some View {
        //TODO: - Allow the user to modify his image?
        VStack {
            if userViewModel.isEditingUser {
                userEdition
            } else {
                userDetail
            }
        }
        .padding()
    }
    
    private func deleteUser(user: User) {
        do {
            try userViewModel.delete(user)
            dismiss()
        } catch {
            print("error while deleting user: \(error.localizedDescription)")
        }
    }
}

extension UserDetailView {
    private var userEdition: some View {
        ScrollView {
            UserImage(user: user, size: 95)
            TextField("Name", text: $userViewModel.modifiedName)
                .textFieldStyle()
            DividerSpacer(height: 40)
            RoomsAndTasks(user: user)
            userEditionButtons
            
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    do {
                        user.name = userViewModel.modifiedName
                        try userViewModel.updateUser()
                    } catch {
                        print("Error while editing: \(error)")
                    }
                    userViewModel.isEditingUser = false
                }
                .disabled(!userViewModel.isValidName(userViewModel.modifiedName))
            }
        }
        .confirmationAlert(isPresented: $showingDeleteAlert, title: "Are you sure you want to delete this user?",
            confirmAction: {
                if let userToDelete = userToDelete {
                    deleteUser(user: userToDelete)
                }
            }
        )
    }
    
    private var userDetail: some View {
        VStack {
            UserProfile(user: user)
            DividerSpacer(height: 40)
            RoomsAndTasks(user: user)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") {
                    userViewModel.startEdition(user: user)
                }
            }
        }
    }
    
    private var userEditionButtons: some View {
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
}
