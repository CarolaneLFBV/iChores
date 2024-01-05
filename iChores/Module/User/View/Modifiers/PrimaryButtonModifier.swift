//
//  ButtonModifier.swift
//  iChores
//
//  Created by Carolane Lefebvre on 05/01/2024.
//

import SwiftUI

struct PrimaryButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

extension View {
    func primaryButtonStyle() -> some View {
        modifier(PrimaryButtonModifier())
    }
}
