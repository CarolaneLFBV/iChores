import SwiftUI

struct ConfirmationAlert: ViewModifier {
    @Binding var isPresented: Bool
    let title: String
    //let message: String
    let confirmAction: () -> Void
    
    func body(content: Content) -> some View {
        content.alert(isPresented: $isPresented) {
            Alert(
                title: Text(title),
                message: Text("This action cannot be undone."),
                primaryButton: .destructive(Text("Delete"), action: confirmAction),
                secondaryButton: .cancel()
            )
        }
    }
}

extension View {
    func confirmationAlert(isPresented: Binding<Bool>, title: String,  confirmAction: @escaping () -> Void) -> some View {
        self.modifier(ConfirmationAlert(isPresented: isPresented, title: title, confirmAction: confirmAction))
    }
}
