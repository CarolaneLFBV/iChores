//
//  ContentView.swift
//  iChores
//
//  Created by Carolane Lefebvre on 21/12/2023.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            RoomsListView()
                .tabItem {
                    Label("Rooms", systemImage: "square.split.bottomrightquarter")
                }
            
            UsersListView()
                .tabItem {
                    Label("Users", systemImage: "person.2")
                }
            
            UserProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}
#Preview {
    ContentView()
}
