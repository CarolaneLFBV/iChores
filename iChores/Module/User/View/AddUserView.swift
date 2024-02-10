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
    @State private var showingImagePicker = false
    
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
                showingImagePicker = true
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
                        try userViewModel.fetchUsers(context: moc)
//                        userViewModel.isSheetPresented = true
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
                .primaryButtonStyle(isEnabled: userViewModel.isValidName(userName))
                
                Spacer()
            }
            Spacer()
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: self.$userImage)
        }
//        .sheet(isPresented: $userViewModel.isSheetPresented) {
//            BottomSheetView(title: userViewModel.alertTitle)
//        }
//        .transition(.move(edge: .bottom))
    }
}
