import SwiftUI
import CoreData

struct ContentView: View {
    @State private var userViewModel = UserViewModel()
    @State private var roomViewModel = RoomViewModel()
    @State private var choreViewModel = ChoreViewModel()
    @State private var addUserViewModel = AddUserViewModel()

    var body: some View {
        TabView {
            NavigationStack {
                HomeView(userViewModel: userViewModel, roomViewModel: roomViewModel, choreViewModel: choreViewModel, addUserViewModel: addUserViewModel)
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            NavigationStack {
                RoomsListView(roomViewModel: roomViewModel, userViewModel: userViewModel)
            }
            .tabItem {
                Label("Rooms", systemImage: "square.split.bottomrightquarter")
            }
            
            NavigationStack {
                UsersListView(userViewModel: userViewModel, addUserViewModel: addUserViewModel)
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
