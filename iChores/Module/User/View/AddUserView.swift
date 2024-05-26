import SwiftUI

struct AddUserView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var addUserViewModel: AddUserViewModel
    
    @State private var userName = ""
    @State private var image: Image?
    @State private var userImage: UIImage?
    
    var body: some View {
        VStack {
            profilePicture
            
            DividerSpacer(height: 40)
                    
            nameField
                
            HStack {
                SecondaryButton()
                createButton
            }
        }
        .padding()
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
        TextField("User name", text: $userName)
            .textFieldStyle()
    }
    
    var createButton: some View {
        Button {
            do {
                try addUserViewModel.addUser(name: userName, image: userImage)
                dismiss()
            } catch {
                print("Error while creating user: \(error.localizedDescription)")
            }
        } label: {
            Text("Create")
                .padding()
        }
        .disabled(!addUserViewModel.isValidName(userName))
        .primaryButtonStyle()
    }
}
