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
    
    @State private var isEditing: Bool = false
    @State private var name = ""
    
    var body: some View {
        VStack {
            if let userImage = user.getImage() {
                userImage
                    .resizable()
                    .cornerRadius(50)
                    .padding(.all, 4)
                    .frame(width: 100, height: 100)
                    .background(Color.black.opacity(0.2))
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .padding(8)
            } else {
                Text("Failed to load image")
            }
            
            if isEditing {
                TextField("Name", text: $name)
            } else {
                Text(user.wrappedUserName)
            }
            
        }
        .toolbar {
            if isEditing {
                Button("Save") {
                    user.name = name
                    try? moc.save()
                    isEditing = false
                }
            } else {
                Button("Edit") {
                    isEditing = true
                }
            }
        }
    }
}

