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
            
            userImageProfile
          
            Spacer()
            
            userNameField
            
            Spacer()
            
            userCreateBtn
            
            Spacer()
        }

    }
}

extension AddUserView {
    // MARK: - userImageProfile
    var userImageProfile: some View {
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
            .imageStyle()
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
    var userNameField: some View {
        TextField("User name", text: $userName)
            .textFieldStyle()
    }
    
    // MARK: - userCreateBtn
    var userCreateBtn: some View {
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
