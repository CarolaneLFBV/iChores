import SwiftUI

struct HomeView: View {
    @State var userViewModel: UserViewModel
    @State var roomViewModel: RoomViewModel
    //    @State private var taskViewModel: TaskViewModel
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        ZStack {
            VStack {
                ForEach(userViewModel.users, id: \.self) { user in
                    VStack {
                        HStack {
                            UserImage(user: user).roomUserImage
                            Text(user.wrappedUserName)
                                .font(.title)
                        }
                        
                        ForEach(user.userRoomArray, id: \.self) { room in
                            VStack {
                                Text(room.wrappedRoomName)
                                    .font(.title2)
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.primary)
                    )
                }
            }
            .padding()
                        
            
            VStack {
                Spacer()
                hoverButton
            }
        }
        .task {
            try? userViewModel.fetchUsers(context: moc)
            try? roomViewModel.fetchRooms(context: moc)
        }
        .navigationTitle("Welcome")

    }
}


extension HomeView {
    var hoverButton: some View {
        HStack {
            Spacer()
            
            Menu {
                NavigationLink(destination: AddUserView(userViewModel: userViewModel), label: {
                    Label("Create User", systemImage: "person.fill.badge.plus")
                })
                NavigationLink(destination: AddRoomView(roomViewModel: roomViewModel, userViewModel: userViewModel), label: {
                    Label("Create Room", systemImage: "square.split.bottomrightquarter.fill")
                })
                Button {} label: {
                    Image(systemName: "circle.inset.filled")
                }
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(colorScheme == .dark ? .black : .white)
            }
            .buttonStyle(ButtonStyleView())
        }
    }
}

