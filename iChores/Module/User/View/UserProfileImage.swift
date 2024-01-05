//
//  UserProfileImage.swift
//  iChores
//
//  Created by Carolane Lefebvre on 05/01/2024.
//

import SwiftUI

struct UserProfileImage: View {
    let user: User
    var body: some View {
        Group {
            if let userImage = user.getImage() {
                userImage
                    .resizable()
                    .avatarStyle()
            } else {
                Image(systemName: "person")
            }
        }
    }
}
