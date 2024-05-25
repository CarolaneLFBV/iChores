import SwiftUI

struct UserProfile: View {
    let user: User
    
    var body: some View {
        vertical
    }
    
    var vertical: some View {
        VStack {
            UserImage(user: user, size: 95)
            Text(user.name)
                .font(.title3)
        }
    }
    
    var horizontal: some View {
        HStack {
            UserImage(user: user, size: 45)
            Text(user.name)
                .font(.title3)
        }
        .padding(.all, 4)
    }
}
