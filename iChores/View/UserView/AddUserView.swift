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
    
    @State private var userName = ""
    @State private var image: Image?
    @State private var userImage: UIImage?
    @State private var showingImagePicker = false
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("User's name", text: $userName)
                
                Text("Change Picture")
                    .onTapGesture {
                        showingImagePicker = true
                    }
                
                Image(uiImage: userImage ?? UIImage(systemName: "person.fill")!)
                    .resizable()
                    .cornerRadius(50)
                    .padding(.all, 4)
                    .frame(width: 100, height: 100)
                    .background(Color.black.opacity(0.2))
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .padding(8)
                
                
                Button("Save") {
                    let user = User(context: moc)
                    user.id = UUID()
                    user.name = userName
                    if let imageData = userImage?.jpegData(compressionQuality: 1.0) {
                        let base64String = imageData.base64EncodedString()
                        user.userImage = base64String
                        UserDefaults.standard.set(imageData, forKey: "userImageKey")
                    }
                    
                    try? moc.save()
                    dismiss()
                }
                .navigationTitle("New User")
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(image: self.$userImage)
                }
            }
        }
    }
}

extension AddUserView {
    func loadImage() {
        guard let userImage = userImage else { return }
        image = Image(uiImage: userImage)
    }
}

#Preview {
    AddUserView()
}
