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
                Image(systemName: "person.fill")
                    .resizable()
                    .frame(width: 40, height: 40)
            }
        }
    }
}
