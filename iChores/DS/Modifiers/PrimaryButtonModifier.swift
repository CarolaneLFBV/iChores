import SwiftUI

struct PrimaryButtonModifier: ViewModifier {
    var isEnabled: Bool
    
    private var screenWidthSize: CGFloat {
        UIScreen.main.bounds.width
    }
    
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: screenWidthSize * 0.3)
            .background(isEnabled ? Color.primary : Color.primary.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

extension View {
    func primaryButtonStyle(isEnabled: Bool = true) -> some View {
        modifier(PrimaryButtonModifier(isEnabled: isEnabled))
    }
}
