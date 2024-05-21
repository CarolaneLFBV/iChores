import SwiftUI

struct UserImage: View {
    let user: User
    
    var body: some View {
        Group {
            if let userImage = user.getImage() {
                userImage
                    .resizable()
                    .imageSizeStyle(width: 95, height: 95, contentMode: nil)
                    .imageBorderStyle()
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .padding()
                    .imageSizeStyle(width: 95, height: 95, contentMode: .fit)
                    .imageBorderStyle()
            }
        }
    }
    
    var roomUserImage: some View {
        Group {
            if let userImage = user.getImage() {
                userImage
                    .resizable()
                    .imageSizeStyle(width: 45, height: 45, contentMode: nil)
                    .imageBorderStyle()
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .padding(.all, 8)
                    .imageSizeStyle(width: 45, height: 45, contentMode: .fit)
                    .imageBorderStyle()
            }
        }
    }
}
