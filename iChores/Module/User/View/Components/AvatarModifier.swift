//
//  ImageModifier.swift
//  iChores
//
//  Created by Carolane Lefebvre on 29/12/2023.
//

import SwiftUI

struct AvatarModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(50)
            .padding(.all, 4)
            .frame(width: 100, height: 100)
            .background(Color.black.opacity(0.2))
            .clipShape(Circle())
            .padding(8)
    }
}

extension View {
    func avatarStyle() -> some View {
        modifier(AvatarModifier())
    }
}
