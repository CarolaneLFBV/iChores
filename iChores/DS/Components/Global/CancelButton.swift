import SwiftUI

struct CancelButton: View {
    @Environment(\.dismiss) var dismiss
    private var screenWidthSize: CGFloat {
        UIScreen.main.bounds.width
    }
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Text("Cancel")
                .foregroundStyle(.blue)
        }
        .frame(width: screenWidthSize * 0.2)
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(.blue, lineWidth: 2)
        )
    }
}
