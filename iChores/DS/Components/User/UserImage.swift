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
                Image("no-icon-logo")
                    .resizable()
                    .imageStyle()
            }
        }
    }
    
    var roomUserImage: some View {
        Group {
            if let userImage = user.getImage() {
                userImage
                    .resizable()
                    .frame(width: 40, height: 40)
            } else {
                Image("no-icon-logo")
                    .resizable()
                    .frame(width: 40, height: 40)
            }
        }
    }
}
