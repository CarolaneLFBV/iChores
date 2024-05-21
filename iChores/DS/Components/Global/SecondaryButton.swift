import SwiftUI

struct SecondaryButton: View {
    @Environment(\.dismiss) var dismiss
    
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

