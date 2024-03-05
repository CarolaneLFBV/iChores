//
//  TextFieldModifier.swift
//  iChores
//
//  Created by Carolane Lefebvre on 05/01/2024.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    let screenWidth = UIScreen.main.bounds.size.width

    func body(content: Content) -> some View {
        content
            .frame(width: screenWidth * 0.6)
            .padding(15)
            .background(.gray.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 10))

    }
}

extension View {
    func textFieldStyle() -> some View {
        modifier(TextFieldModifier())
    }
}
