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
            NavigationStack {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
            }
            
            NavigationStack {
                RoomsListView()
                    .tabItem {
                        Label("Rooms", systemImage: "square.split.bottomrightquarter")
                }
            }
            
            NavigationStack {
                UsersListView()
                    .tabItem {
                        Label("Users", systemImage: "person.2")
                }
            }
            
            NavigationStack {
                UserProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person")
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
