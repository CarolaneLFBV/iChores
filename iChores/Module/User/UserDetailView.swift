import SwiftUI

struct UserDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State var userDetailViewModel = UserDetailViewModel()
    @State private var userToDelete: User?
    let user: User
    
    var body: some View {
        ZStack {
            Color("AppBackgroundColor")
            VStack {
                if userDetailViewModel.isEditingUser {
                    userEdition
                } else {
                    userDetail
                }
            }
            .padding()
        }
        .ignoresSafeArea()
    }
}

extension UserDetailView {
    private var userEdition: some View {
        ScrollView {
            UserImage(user: user, size: 95)
            
            TextField("Name", text: $userDetailViewModel.modifiedName)
                .textFieldStyle()
            
            Components.DividerSpacer(height: 40)
            
            RoomsAndTasks(user: user)
            
            userEditionButtons
            
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    user.name = userDetailViewModel.modifiedName
                    userDetailViewModel.update(user)
                }
                .disabled(!userDetailViewModel.isValidName(userDetailViewModel.modifiedName))
            }
        }
        .confirmationAlert(isPresented: $userDetailViewModel.showingDeleteAlert, title: "Are you sure you want to delete this user?",
            confirmAction: {
                if let userToDelete = userToDelete {
                    userDetailViewModel.delete(userToDelete)
                }
            }
        )
    }
    
    private var userDetail: some View {
        VStack {
            UserProfile(user: user)
            Components.DividerSpacer(height: 40)
            RoomsAndTasks(user: user)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Edit") {
                    userDetailViewModel.startEdition(user)
                }
            }
        }
    }
    
    private var userEditionButtons: some View {
        HStack {
            Components.SecondaryButton()
            
            Button {
                userDetailViewModel.showingDeleteAlert = true
                userToDelete = user
            } label: {
                Text("Delete")
                    .padding()
            }
            .deleteButtonStyle()
        }
    }
}
