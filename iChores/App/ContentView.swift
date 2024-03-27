import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomeView(userViewModel: UserViewModel(), roomViewModel: RoomViewModel())
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            NavigationStack {
                RoomsListView()
            }
            .tabItem {
                Label("Rooms", systemImage: "square.split.bottomrightquarter")
            }
            
            NavigationStack {
                UsersListView()
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
