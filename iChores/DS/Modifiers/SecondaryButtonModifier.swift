//
//  SecondaryButtonModifier.swift
//  iChores
//
//  Created by Carolane Lefebvre on 05/01/2024.
//

import SwiftUI

struct SecondaryButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: 100)
            .overlay(
                   RoundedRectangle(cornerRadius: 16)
                       .stroke(.blue, lineWidth: 2)
               )
    }
}

extension View {
    func secondaryButtonStyle() -> some View {
        modifier(SecondaryButtonModifier())
    }
}
