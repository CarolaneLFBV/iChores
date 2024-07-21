import SwiftUI

struct PrimaryTagModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 7)
            .background(Color("AppPrimaryColor"))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .foregroundColor(Color("AppWhiteColor"))
    }
}

struct SecondaryTagModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.all, 7)
            .background(Color("AppSecondaryColor"))
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .foregroundColor(Color("AppWhiteColor"))
    }
}
// MARK: - Extension View
extension View {
    func primaryTag() -> some View {
        modifier(PrimaryTagModifier())
    }
    
    func secondaryTag() -> some View {
        modifier(SecondaryTagModifier())
    }
}

