//
//  ButtonModifier.swift
//  iChores
//
//  Created by Carolane Lefebvre on 05/01/2024.
//

import SwiftUI

struct PrimaryButtonModifier: ViewModifier {
    var isEnabled: Bool
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: 100)
            .background(isEnabled ? Color.blue : Color.blue.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

extension View {
    func primaryButtonStyle(isEnabled: Bool = true) -> some View {
        modifier(PrimaryButtonModifier(isEnabled: isEnabled))
    }
}
