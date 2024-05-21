import SwiftUI

// MARK: - ImageModifier
struct ImageBorder: ViewModifier {
    func body(content: Content) -> some View {
        content
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

// MARK: - ImageSizeModifier
struct ImageSizeModifier: ViewModifier {
    var width: CGFloat?
    var height: CGFloat?
    var contentMode: ContentMode = .fit

    func body(content: Content) -> some View {
        content
            .aspectRatio(contentMode: contentMode)
            .frame(width: width, height: height)
            .scaledToFit()
    }
}

// MARK: - Extension View
extension View {
    func userImageStyle() -> some View {
        modifier(UserImageModifier())
    }
    
    func imageBorderStyle() -> some View {
        modifier(ImageBorder())
    }
    
    func imageSizeStyle(width: CGFloat? = nil, height: CGFloat? = nil, contentMode: ContentMode = .fit) -> some View {
        self.modifier(ImageSizeModifier(width: width, height: height, contentMode: contentMode))
    }
}
