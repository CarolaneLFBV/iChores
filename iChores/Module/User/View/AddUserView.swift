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
    
    let screenWidth = UIScreen.main.bounds.size.width
    let screenHeight = UIScreen.main.bounds.size.height
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(uiImage: userImage ?? UIImage(systemName: "person.fill")!)
                .resizable()
                .avatarStyle()
                .onTapGesture {
                    showingImagePicker = true
                }

            Spacer()
                .frame(height: 50)

            TextField("User name", text: $userName)
                .frame(width: screenWidth * 0.6)
                .padding(15)
                .background(.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                        .foregroundStyle(.blue)
                }
                .secondaryButtonStyle()
                
                Spacer()
                
                Button {
                    do {
                        try userViewModel.addUser(context: moc, name: userName, image: userImage)
                    } catch {
                        // TODO: turn into alert
                        print("Error while creating user: \(error.localizedDescription)")
                    }
                    dismiss()
                } label: {
                    Text("Create")
                        .foregroundStyle(.white)
                }
                .disabled(!userViewModel.isValidName(userName))
                .primaryButtonStyle()
                
                Spacer()
            }

            
            Spacer()

        }
        .navigationTitle("New User")
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: self.$userImage)
        }
    }
}

#Preview {
    AddUserView()
}
