import SwiftUI

struct OnBoardingItem: Identifiable {
    var id: UUID = UUID()
    var title: String
    var headline: String
    var image: String
    var gradientColors: [Color]
}

extension OnBoardingItem {
    static var items: [OnBoardingItem] = [
        OnBoardingItem(title: "Welcome", headline: "test1", image: "testImage", gradientColors: [.red, .green]),
        OnBoardingItem(title: "Create your rooms", headline: "test2", image: "testImage", gradientColors: [.blue, .yellow]),
        OnBoardingItem(title: "Create your users", headline: "test3", image: "testImage", gradientColors: [.pink, .purple])

    ]
}
