import SwiftUI

extension Components {
    struct UserImage: View {
        let user: User
        let size: CGFloat
        
    }
}

extension Components.UserImage {
    var body: some View {
        Group {
            if let userImage = user.getImage() {
                userImage
                    .resizable()
                    .imageSizeStyle(width: size, height: size, contentMode: nil)
                    .imageBorderStyle()
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .padding()
                    .imageSizeStyle(width: size, height: size, contentMode: .fit)
                    .imageBorderStyle()
            }
        }
    }
}
