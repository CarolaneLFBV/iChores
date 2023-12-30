//
//  AddUserView.swift
//  iChores
//
//  Created by Carolane Lefebvre on 28/12/2023.
//

import SwiftUI

struct AddUserView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var userViewModel = UserViewModel()
    
    @State private var userName = ""
    @State private var image: Image?
    @State private var userImage: UIImage?
    @State private var showingImagePicker = false
    
    var body: some View {
        Form {
            TextField("User's name", text: $userName)
            
            Text("Change Picture")
                .onTapGesture {
                    showingImagePicker = true
                }
            
            Image(uiImage: userImage ?? UIImage(systemName: "person.fill")!)
                .resizable()
                .avatarStyle()
            
            
            Button("Save") {
                do {
                    try userViewModel.addUser(context: moc, name: userName, image: userImage)
                } catch {
                    // TODO: turn into alert
                    print("Error while creating user: \(error.localizedDescription)")
                }
                dismiss()
            }
            .navigationTitle("New User")
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: self.$userImage)
            }
        }
        
    }
}

extension AddUserView {
    
}

#Preview {
    AddUserView()
}
