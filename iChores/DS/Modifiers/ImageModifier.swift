import SwiftUI

// MARK: - ImageModifier
struct ImageBorder: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("AppPrimaryColor"), lineWidth: 3)
            )
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

// MARK: - ImageSizeModifier
struct ImageSizeModifier: ViewModifier {
    var width: CGFloat?
    var height: CGFloat?
    var contentMode: ContentMode?

    func body(content: Content) -> some View {
        content
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .aspectRatio(contentMode: contentMode ?? .fit)
    }
}

// MARK: - Extension View
extension View {
    func imageBorderStyle() -> some View {
        modifier(ImageBorder())
    }
    
    func imageSizeStyle(width: CGFloat? = nil, height: CGFloat? = nil, contentMode: ContentMode? = nil) -> some View {
        self.modifier(ImageSizeModifier(width: width, height: height, contentMode: contentMode))
    }
}
