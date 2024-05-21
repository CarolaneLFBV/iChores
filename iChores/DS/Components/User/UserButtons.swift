import SwiftUI

struct UserButtons: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @State var userViewModel: UserViewModel
    let user: User
    
    var body: some View {
        updateButton
    }
    
    var updateButton: some View {
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
    
    var editUsersListButton: some View {
        Button {
            userViewModel.isEditingUsersList.toggle()
        } label: {
            Label("Edit", systemImage: userViewModel.isEditingUsersList ? "checkmark" : "pencil")
        }
    }
    
    var editButton: some View {
        Button("Edit") {
            userViewModel.startEdition(user: user)
        }
    }
    
    
    var deleteUserList: some View {
        VStack {
            if userViewModel.isEditingUsersList {
                Button {
                    do {
                        try userViewModel.delete(user, context: moc)
                    } catch {
                        // TODO: Turn into alert
                        print("Error while deleting user: \(error.localizedDescription)")
                    }
                } label: {
                    ListDeleteButton()
                }
            }
        }
    }
}
