import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("AppPrimaryColor"), lineWidth: 1)
            )
            
    }
}

extension View {
    func textFieldStyle() -> some View {
        modifier(TextFieldModifier())
    }
}
