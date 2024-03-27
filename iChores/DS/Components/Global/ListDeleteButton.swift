import SwiftUI

struct ListDeleteButton: View {
    var body: some View {
        Image(systemName: "xmark.circle.fill")
            .foregroundColor(.red)
            .background(Circle().foregroundColor(.white))
            .padding(4)
    }
}
