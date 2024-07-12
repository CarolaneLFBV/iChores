import SwiftUI

struct AddUserView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var addUserViewModel = AddUserViewModel()
    
    @State private var name = ""
    @State private var image: Image?
    @State private var userImage: UIImage?
    
    var body: some View {
        ZStack {
            Color("AppBackgroundColor")
            VStack {
                profilePicture
                
                Components.DividerSpacer(height: 40)
                        
                nameField
                    
                HStack {
                    Components.SecondaryButton()
                    createButton
                }
            }
            .padding()
        }
        .ignoresSafeArea()
    }
}

extension AddUserView {
    var profilePicture: some View {
        VStack {
            Group {
                if let userImage {
                    Image(uiImage: userImage)
                        .resizable()
                } else {
                    Image(systemName: "person.fill")
                        .resizable()
                        .padding()
                }
            }
            .imageSizeStyle(width: 95, height: 95, contentMode: .fit)
            .imageBorderStyle()
            .onTapGesture {
                addUserViewModel.showingImagePicker = true
            }
            
            Text("Tap to change the picture")
                .font(.caption)
                .foregroundStyle(.gray)
        }
        .sheet(isPresented: $addUserViewModel.showingImagePicker) {
            ImagePicker(image: self.$userImage)
        }
    }
    
    var nameField: some View {
        TextField("User name", text: $name)
            .textFieldStyle()
    }
    
    var createButton: some View {
        Button {
            addUserViewModel.addUser(name: name, image: userImage)
           dismiss()
        } label: {
            Text("Create")
                .padding()
        }
        .disabled(!addUserViewModel.isValidName(name))
        .primaryButtonStyle()
    }
}
