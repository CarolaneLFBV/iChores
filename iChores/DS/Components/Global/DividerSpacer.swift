import SwiftUI

struct DividerSpacer: View {
    let height: CGFloat
    
    var body: some View {
        spacer
    }
    
    var spacer: some View {
        Spacer()
            .frame(height: height)
    }
}
