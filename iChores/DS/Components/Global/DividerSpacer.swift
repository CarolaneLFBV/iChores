import SwiftUI

extension Components {
    struct DividerSpacer: View {
        let height: CGFloat
    }
}

extension Components.DividerSpacer {
    var body: some View {
        Spacer()
            .frame(height: height)
    }
}

