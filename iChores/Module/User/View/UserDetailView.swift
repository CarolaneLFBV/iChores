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
    var userEdition: some View {
        ScrollView {
            TextField("Name", text: $userViewModel.modifiedName)
                .textFieldStyle()
            
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
            
            RoomsAndTasks(user: user)
        }
        .padding()
        .toolbar {
            UserButtons(moc: _moc, userViewModel: userViewModel, user: user).updateButton
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
            DividerSpacer(height: 40)
            RoomsAndTasks(user: user)
        }
        .toolbar {
            UserButtons(userViewModel: userViewModel, user: user).editButton
        }
    }
}


