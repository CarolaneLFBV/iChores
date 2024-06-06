import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
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
}
