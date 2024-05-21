import SwiftUI

//MARK: - Primary Button
struct PrimaryButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .buttonStyle(.borderedProminent)
    }
}

//MARK: - Secondary Button
struct SecondaryButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .buttonStyle(.bordered)
    }
}

//MARK: - Delete Button
struct DeleteButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(maxWidth: .infinity)
            .buttonStyle(.bordered)
            .tint(.red)
    }
}

//MARK: - Button Style
struct ContextMenuButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(.primary)
            .clipShape(Circle())
            .padding([.trailing, .bottom])
    }
}

//MARK: - Extensions
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

