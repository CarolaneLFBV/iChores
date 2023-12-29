//
//  UserDetailView.swift
//  iChores
//
//  Created by Carolane Lefebvre on 28/12/2023.
//

import SwiftUI

struct UserDetailView: View {
    @Environment(\.managedObjectContext) var moc
    let user: User

    var body: some View {
        VStack {
            Text(user.wrappedUserName)
            
            if let imageData = UserDefaults.standard.data(forKey: "userImageKey") {
                if let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                }
            }
        }
    }
}

