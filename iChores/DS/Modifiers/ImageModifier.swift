//
//  ImageModifier.swift
//  iChores
//
//  Created by Carolane Lefebvre on 29/12/2023.
//

import SwiftUI

struct ImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 4)
            .frame(width: 100, height: 100)
//            .background(.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .black.opacity(0.5), radius: 7, x: 3, y: 5)
            .padding(8)
    }
}

extension View {
    func imageStyle() -> some View {
        modifier(ImageModifier())
    }
}
