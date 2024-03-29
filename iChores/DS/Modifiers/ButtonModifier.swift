import SwiftUI

struct PrimaryButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .buttonStyle(.borderedProminent)
    }
}

struct SecondaryButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .buttonStyle(.bordered)
    }
}

struct DeleteButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .buttonStyle(.bordered)
            .tint(.red)
    }
}

struct ButtonStyleView: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.primary)
            .clipShape(Circle())
            .padding([.trailing, .bottom])
    }
}

extension View {
    func primaryButtonStyle() -> some View {
        modifier(PrimaryButtonModifier())
    }
    
    func secondaryButtonStyle() -> some View {
        modifier(SecondaryButtonModifier())
    }
    
    func deleteButtonStyle() -> some View {
        modifier(DeleteButtonModifier())
    }
}

