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
                    ChoreListView()
                }
                .tabItem {
                    Label("Chores", systemImage: "list.bullet")
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
                
            }
            .accentColor(Color("AppPrimaryColor"))
        }
    }
}
