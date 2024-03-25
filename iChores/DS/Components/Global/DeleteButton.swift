import SwiftUI

struct DeleteButton: View {
    var body: some View {
        Image(systemName: "xmark.circle.fill")
            .foregroundColor(.red)
            .background(Circle().foregroundColor(.white))
            .padding(4)
    }
    
    var squareBtn: some View {
        Text("Delete")
            .padding()
            .foregroundColor(.white)
            .background(.red)
            .clipShape(
                RoundedRectangle(cornerRadius: 10)
            )
    }
}
