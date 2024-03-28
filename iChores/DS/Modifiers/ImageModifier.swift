import SwiftUI

// MARK: - ImageModifier
struct ImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 65, height: 65)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.primary, lineWidth: 3)
            )
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding()

    }
}

// MARK: - UserImageModifier
struct UserImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 95, height: 95)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .overlay(RoundedRectangle(cornerRadius: 8)
                .stroke(.primary, lineWidth: 1)
            )
            .padding()

    }
}

// MARK: - Extension View
extension View {
    func userImageStyle() -> some View {
        modifier(UserImageModifier())
    }
    
    func imageStyle() -> some View {
        modifier(ImageModifier())
    }
}
