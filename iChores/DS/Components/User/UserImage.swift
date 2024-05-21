import SwiftUI

struct UserImage: View {
    let user: User
    
    var body: some View {
        Group {
            if let userImage = user.getImage() {
                userImage
                    .resizable()
                    .userImageStyle()
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .imageSizeStyle(width: 65, height: 65, contentMode: .fill)
                    .imageBorderStyle()
            }
        }
    }
    
    var roomUserImage: some View {
        Group {
            if let userImage = user.getImage() {
                userImage
                    .resizable()
                    .imageSizeStyle(width: 30, height: 30, contentMode: .fill)
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .imageSizeStyle(width: 30, height: 30, contentMode: .fit)
            }
        }
    }
}
