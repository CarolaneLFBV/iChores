import SwiftUI

struct OnBoardingItem: Identifiable {
    var id: UUID = UUID()
    var title: String
    var headline: String
    var image: String
    var backgroundColor: Color
}

extension OnBoardingItem {
    static var items: [OnBoardingItem] = [
        OnBoardingItem(title: "Welcome", headline: "Welcome to iChores, the application that helps your household to stay clean and neat!", image: "waving-hand", backgroundColor: Color("AppBackgroundColor")),
        OnBoardingItem(title: "Rooms, Users and Tasks", headline: "You can create your own users, and attributes them rooms and tasks!", image: "house-cleaning", backgroundColor: Color("AppBackgroundColor")),
        OnBoardingItem(title: "Get started", headline: "Let's get into it!", image: "testImage", backgroundColor: Color("AppBackgroundColor")),
        

    ]
}
