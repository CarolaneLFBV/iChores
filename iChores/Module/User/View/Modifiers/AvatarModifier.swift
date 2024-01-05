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
            .padding(.all, 4)
            .frame(width: 100, height: 100)
            .background(.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .padding(8)
    }
}

extension View {
    func avatarStyle() -> some View {
        modifier(AvatarModifier())
    }
}
