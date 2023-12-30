//
//  UserDetailView.swift
//  iChores
//
//  Created by Carolane Lefebvre on 28/12/2023.
//

import SwiftUI

struct UserDetailView: View {
    @Environment(\.managedObjectContext) var moc
    let user: User
    
    @State private var userViewModel = UserViewModel()
    
    @State var isEditing: Bool = false
    @State var modifiedName = ""
    
    var body: some View {
        VStack {
            if let userImage = user.getImage() {
                userImage
                    .resizable()
                    .avatarStyle()
            } else {
                Text("Failed to load image")
            }
                     
        }
        .toolbar {
            if isEditing {
                Button("Save") {
                    do {
                        try userViewModel.editUser(user: user, withModifiedName: modifiedName, context: moc)
                    } catch {
                        // TODO: turn into alert
                        print("Error while editing: \(error)")
                    }
                }
            } else {
                Button("Edit") {
                    isEditing = true
                }
            }
        }
    }
}

