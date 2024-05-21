import SwiftUI

struct UserDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State var userViewModel: UserViewModel
    
    @State private var showingDeleteAlert = false
    @State private var userToDelete: User?
    
    let user: User
    
    func deleteUser(user: User) {
        do {
            try userViewModel.delete(user, context: moc)
            dismiss()
        } catch {
            print("error while deleting user: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        //TODO: - Allow the user to modify his image?
        VStack {
            if userViewModel.isEditingUser {
                UserImage(user: user)
                userEdition
            } else {
                UserProfile(user: user)
                userDetail
            }
        }
        .padding()
    }
}


extension UserDetailView {
    // MARK: - userEdition
    private var userEdition: some View {
        ScrollView {
            TextField("Name", text: $userViewModel.modifiedName)
                .textFieldStyle()
            
            DividerSpacer(height: 40)

            RoomsAndTasks(user: user)
            
            userEditionButtons

        }
        .toolbar {
            updateButton
        }
        .confirmationAlert(
            isPresented: $showingDeleteAlert,
            title: "Are you sure you want to delete this user?",
            confirmAction: {
                if let userToDelete = userToDelete {
                    deleteUser(user: userToDelete)
                }
            }
        )
    }
    
    // MARK: - userDetail
    private var userDetail: some View {
        VStack {
            DividerSpacer(height: 40)
            RoomsAndTasks(user: user)
        }
        .toolbar {
            Button("Edit") {
                userViewModel.startEdition(user: user)
            }
        }
    }
}

extension UserDetailView {
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
    
    private var updateButton: some View {
        Button {
            do {
                user.name = userViewModel.modifiedName
                try userViewModel.updateUser(context: moc)
            } catch {
                print("Error while editing: \(error)")
            }
            userViewModel.isEditingUser = false
        } label: {
            Text("Save")
        }
        .disabled(!userViewModel.isValidName(userViewModel.modifiedName))
    }
}
