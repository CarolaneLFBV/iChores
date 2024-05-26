import SwiftUI

struct UserDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State var userCoreDataHelper: UserCoreDataHelper
    @State var userDetailViewModel: UserDetailViewModel

    @State private var userToDelete: User?
    
    let user: User
    
    private func deleteUser(user: User) {
        do {
            try userDetailViewModel.delete(user: user)
            dismiss()
        } catch {
            print("error while deleting user: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        VStack {
            if userDetailViewModel.isEditingUser {
                userEdition
            } else {
                userDetail
            }
        }
        .padding()
    }
}

extension UserDetailView {
    private var userEdition: some View {
        ScrollView {
            UserImage(user: user, size: 95)
            TextField("Name", text: $userDetailViewModel.modifiedName)
                .textFieldStyle()
            DividerSpacer(height: 40)
            RoomsAndTasks(user: user)
            userEditionButtons
            
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    do {
                        user.name = userDetailViewModel.modifiedName
                        try userDetailViewModel.update(user: user)
                    } catch {
                        print("Error while editing: \(error)")
                    }
                    dismiss()
                }
                .disabled(!userDetailViewModel.isValidName(userDetailViewModel.modifiedName))
            }
        }
        .confirmationAlert(isPresented: $userCoreDataHelper.showingDeleteAlert, title: "Are you sure you want to delete this user?",
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
                    userDetailViewModel.startEdition(user: user)
                }
            }
        }
    }
    
    private var userEditionButtons: some View {
        HStack {
            SecondaryButton()
            
            Button {
                userCoreDataHelper.showingDeleteAlert = true
                userToDelete = user
            } label: {
                Text("Delete")
                    .padding()
            }
            .deleteButtonStyle()
        }
    }
}
