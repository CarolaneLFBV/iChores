import SwiftUI

struct HomeView: View {
    @State var userViewModel: UserViewModel
    @State var roomViewModel: RoomViewModel
    //    @State private var taskViewModel: TaskViewModel
    
    var body: some View {
        ZStack {
            Text("Hello World")
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    Menu {
                        NavigationLink(destination: AddUserView(userViewModel: userViewModel), label: {
                            Label("Add User", systemImage: "person.fill.badge.plus")
                        })
                        NavigationLink(destination: AddRoomView(roomViewModel: roomViewModel, userViewModel: userViewModel), label: {
                            Label("Add Room", systemImage: "square.split.bottomrightquarter.fill")
                        })
                        Button {} label: {
                            Image(systemName: "circle.inset.filled")
                        }
                    } label: {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(ButtonStyleView())
                }
            }
        }
        .navigationTitle("Welcome")
    }
}

