import SwiftUI

struct HomeView: View {
    @State var userViewModel: UserViewModel
    @State var roomViewModel: RoomViewModel
    @State var taskViewModel: TaskViewModel
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        ZStack {
            VStack {
                ForEach(userViewModel.users, id: \.self) { user in
                    VStack(alignment: .leading) {
                        HStack {
                            UserImage(user: user).roomUserImage
                            Text(user.wrappedUserName)
                                .font(.title)
                        }
                        
                        ForEach(taskViewModel.tasks, id: \.self) { task in
                            Text(task.wrappedTaskTitle)
//                            TaskCategoryView(task: task)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
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
            try? taskViewModel.fetchTasks(context: moc)
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
                NavigationLink(destination: AddTaskView(taskViewModel: taskViewModel, roomViewModel: roomViewModel, userViewModel: userViewModel), label: {
                    Label("Create Task", systemImage: "circle.inset.filled")
                })
            } label: {
                Image(systemName: "plus")
                    .foregroundStyle(colorScheme == .dark ? .black : .white)
            }
            .buttonStyle(ButtonStyleView())
        }
    }
}


