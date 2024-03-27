import SwiftUI

struct PrimaryButtonModifier: ViewModifier {
    var isEnabled: Bool
    
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .buttonStyle(.borderedProminent)
            .tint(isEnabled ? Color.primary : Color.primary.opacity(0.5))
    }
}

struct SecondaryButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .buttonStyle(.bordered)
//          .tint(.red)
    }
}

struct ButtonStyleView: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.black.opacity(0.75))
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding([.trailing, .bottom])
    }
}

extension View {
    func primaryButtonStyle(isEnabled: Bool = true) -> some View {
        modifier(PrimaryButtonModifier(isEnabled: isEnabled))
    }
    
    func secondaryButtonStyle() -> some View {
        modifier(SecondaryButtonModifier())
    }
}

