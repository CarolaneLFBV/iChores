import SwiftUI
import CoreData

struct ContentView: View {
    @State private var userCoreDataHelper = UserCoreDataHelper()
    @State private var userListViewModel = UserListViewModel()
    @State private var addUserViewModel = AddUserViewModel()
    @State private var userDetailViewModel = UserDetailViewModel()

    @State private var roomCoreDataHelper = RoomCoreDataHelper()
    @State private var roomListViewModel = RoomListViewModel()
    @State private var addRoomViewModel = AddRoomViewModel()
    @State private var roomDetailViewModel = RoomDetailViewModel()

    @State private var choreCoreDataHelper = ChoreCoreDataHelper()
    @State private var addChoreViewModel = AddChoreViewModel()
    @State private var editChoreViewModel = EditChoreViewModel()

    var body: some View {
        TabView {
            NavigationStack {
                HomeView(userCoreDataHelper: userCoreDataHelper, roomCoreDataHelper: roomCoreDataHelper, choreCoreDataHelper: choreCoreDataHelper, addUserViewModel: addUserViewModel, addRoomViewModel: addRoomViewModel, addChoreViewModel: addChoreViewModel, editChoreViewModel: editChoreViewModel)
            }
            .tabItem {
                Label("Home", systemImage: "house")
            }
            
            NavigationStack {
                RoomListView(userCoreDataHelper: userCoreDataHelper, roomCoreDataHelper: roomCoreDataHelper, roomListViewModel: roomListViewModel, roomDetailViewModel: roomDetailViewModel, addRoomViewModel: addRoomViewModel)
            }
            .tabItem {
                Label("Rooms", systemImage: "square.split.bottomrightquarter")
            }
            
            NavigationStack {
                UserListView(userCoreDataHelper: userCoreDataHelper, userListViewModel: userListViewModel, addUserViewModel: addUserViewModel, userDetailViewModel: userDetailViewModel)
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
