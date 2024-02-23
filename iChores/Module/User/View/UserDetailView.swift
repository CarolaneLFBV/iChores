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
                CancelBtnView()

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
    }
    
    var userDetail: some View {
        Group {
            Text(user.wrappedUserName)
        }
        .toolbar {
            Button("Edit") {
                userViewModel.startEdition(user: user)
            }
        }
    }
}


