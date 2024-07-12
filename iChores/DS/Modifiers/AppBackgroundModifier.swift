import SwiftUI

struct AppBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color("AppBackgroundColor"))
            .edgesIgnoringSafeArea(.all)
    }
}

extension View {
    func applyAppBackground() -> some View {
        self.modifier(AppBackgroundModifier())
    }
}
