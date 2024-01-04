//
//  UserDetailView+Edition.swift
//  iChores
//
//  Created by Carolane Lefebvre on 30/12/2023.
//

import SwiftUI

extension UserDetailView {
    var userEdition: some View {
        Group {
            TextField("Name", text: $modifiedName)
        }
        .toolbar {
            Button("Save") {
                do {
                    try userViewModel.editUser(user: user, withModifiedName: modifiedName, context: moc)
                } catch {
                    // TODO: turn into alert
                    print("Error while editing: \(error)")
                }
            }
        }
    }
    
    var userDetail: some View {
        Group {
            Text(user.wrappedUserName)
        }
        .toolbar {
            Button("Edit") {
                isEditing = true
            }
        }
    }
}
