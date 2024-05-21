import SwiftUI


struct BorderModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.primary)
            )


    }
}
// MARK: - Extension View
extension View {
    func homeBorder() -> some View {
        modifier(BorderModifier())
    }
}

