import SwiftUI

extension Components {
    struct SecondaryButton: View {
        @Environment(\.dismiss) var dismiss
    }
}

extension Components.SecondaryButton {
    var body: some View {
        Button {
            dismiss()
        } label: {
            Text("Cancel")
                .padding()
        }
        .secondaryButtonStyle()
    }
}
