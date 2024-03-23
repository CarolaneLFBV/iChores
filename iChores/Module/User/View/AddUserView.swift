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
    
    @State var userViewModel: UserViewModel

    @State private var userName = ""
    @State private var image: Image?
    @State private var userImage: UIImage?
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                Group {
                    if let userImage {
                        Image(uiImage: userImage)
                            .resizable()
                    } else {
                        Image(systemName: "person.fill")
                            .resizable()
                    }
                }
            }
            .imageStyle()
            .onTapGesture {
                userViewModel.showingImagePicker = true
            }
            
            Text("Tap to change the picture")
                .font(.caption)
                .foregroundStyle(.gray)

            Spacer()
                .frame(height: 50)

            TextField("User name", text: $userName)
                .textFieldStyle()
             
            Spacer()
            
            HStack {                
                Spacer()
                
                Button {
                    do {
                        try userViewModel.addUser(context: moc, name: userName, image: userImage)
                        dismiss()
                    } catch {
                        // TODO: turn into alert
                        print("Error while creating user: \(error.localizedDescription)")
                    }
                } label: {
                    Text("Create")
                        .foregroundStyle(.white)
                }
                .disabled(!userViewModel.isValidName(userName))
                .primaryButtonStyle(isEnabled: userViewModel.isValidName(userName))
                
                Spacer()
            }
            Spacer()
        }
        .sheet(isPresented: $userViewModel.showingImagePicker) {
            ImagePicker(image: self.$userImage)
        }
    }
}
