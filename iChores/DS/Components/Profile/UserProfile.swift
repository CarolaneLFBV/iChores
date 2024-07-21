import SwiftUI

extension Components {
    struct UserProfile: View {
        let user: User
        let vertical: Bool
    }
}

extension Components.UserProfile {
    var body: some View {
        Group {
            if vertical {
                VStack {
                    profileUserImage
                    profileUserText
                }
            } else {
                HStack {
                    profileUserImage
                    profileUserText
                }
            }
        }
    }
    
    private var profileUserImage: some View {
        Components.UserImage(user: user, size: vertical ? 95 : 50)
    }
    
    private var profileUserText: some View {
        Text(user.name)
            .font(.title3)
    }
    
    var choreProfileUser: some View {
        HStack {
            Components.UserImage(user: user, size: 30)
            Text(user.name)
        }
    }
}
