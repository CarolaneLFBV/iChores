import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var homeViewModel = HomeViewModel()
    
    var body: some View {
        ZStack {
            ScrollView {
                userSection
            }
            contextMenuButton
        }
        .task {
            homeViewModel.loadData()
        }
        .navigationTitle("Home")
    }
}


extension HomeView {
    private var userSection: some View {
        VStack(alignment: .leading) {
            ForEach(homeViewModel.users, id: \.idUser) { user in
                VStack(alignment: .leading) {
                    UserProfile(user: user).horizontal
                    
                    ForEach(user.userChoreArray, id: \.self) { chore in
                        ChoreRowView(chore: chore)
                    }
                }
            }
        }
        .padding()
    }
    
    private var contextMenuButton: some View {
        VStack {
            Spacer()
            
            HStack {
                Spacer()
                
                Menu {
                    NavigationLink(destination: AddUserView(), label: {
                        Label("Create User", systemImage: "person.fill.badge.plus")
                    })
                    NavigationLink(destination: AddRoomView(), label: {
                        Label("Create Room", systemImage: "square.split.bottomrightquarter.fill")
                    })
//                    if !homeViewModel.users.isEmpty && !homeViewModel.rooms.isEmpty {
                        NavigationLink(destination: AddChoreView(), label: {
                            Label("Create Task", systemImage: "circle.inset.filled")
                        })
//                    }
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(colorScheme == .dark ? .black : .white)
                }
                .buttonStyle(ContextMenuButton())
            }
        }
    }
}


