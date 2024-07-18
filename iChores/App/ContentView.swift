import SwiftUI
import CoreData

struct ContentView: View {
    @AppStorage("isOnBoarding") var isOnBoarding: Bool = true
    @State var onBoardingItems: [OnBoardingItem] = OnBoardingItem.items

    var body: some View {
        if isOnBoarding {
            TabView {
                ForEach(onBoardingItems.indices, id: \.self) { index in
                    OnBoardingView(onBoardingItem: onBoardingItems[index], isLastItem: index == onBoardingItems.count - 1)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .ignoresSafeArea()
        } else {
            TabView {
                NavigationStack {
                    HomeView()
                }
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                
                NavigationStack {
                    RoomListView()
                }
                .tabItem {
                    Label("Rooms", systemImage: "square.split.bottomrightquarter")
                }
                
                NavigationStack {
                    UserListView()
                }
                .tabItem {
                    Label("Users", systemImage: "person.2")
                }
                
                NavigationStack {
                    SettingsView()
                }
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
            }
        }
        .accentColor(Color("AppPrimaryColor"))
    }
}
