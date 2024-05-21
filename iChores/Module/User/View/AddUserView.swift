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
    // MARK: - userImageProfile
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
                userViewModel.showingImagePicker = true
            }
            
            Text("Tap to change the picture")
                .font(.caption)
                .foregroundStyle(.gray)
        }
        .sheet(isPresented: $userViewModel.showingImagePicker) {
            ImagePicker(image: self.$userImage)
        }
    }
    
    // MARK: - userNameField
    var nameField: some View {
        TextField("User name", text: $userName)
            .textFieldStyle()
    }
    
    // MARK: - userCreateBtn
    var createButton: some View {
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
                .padding()
        }
        .disabled(!userViewModel.isValidName(userName))
        .primaryButtonStyle()
    }
}
