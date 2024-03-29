import SwiftUI

struct AddTaskView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State var taskViewModel: TaskViewModel
    @State var roomViewModel: RoomViewModel
    @State var userViewModel: UserViewModel
    
    @State private var taskTitle = ""
    @State private var selectedCategory = "Not Urgent and Not Important"
    let categories = ["Urgent and Important", "Urgent but Not Important", "Not Urgent but Important", "Not Urgent and Not Important"]
    
    @State private var selectedUser: User?
    @State private var selectedRoom: Room?
    
    var body: some View {
        VStack {
            taskField
            taskCategoryPicker
            taskRoomPicker
            taskUserPicker
            
            Spacer()
                .frame(height: 48)
            
            taskCreateBtn
        }
        .onAppear {
            try? userViewModel.fetchUsers(context: moc)
            try? roomViewModel.fetchRooms(context: moc)
        }
    }
}

extension AddTaskView {
    var taskField: some View {
        TextField("Task's title", text: $taskTitle)
            .textFieldStyle()
    }
    
    var taskCategoryPicker: some View {
        Picker("Category", selection: $selectedCategory) {
            ForEach(categories, id: \.self) { ctgo in
                Text(ctgo)
            }
        }
        .pickerStyle(.navigationLink)
        .textFieldStyle()
    }
    
    var taskRoomPicker: some View {
        Picker("Room", selection: $selectedRoom) {
            ForEach(roomViewModel.rooms, id: \.self) { room in
                VStack {
                    Text(room.wrappedRoomName)
                }
                .tag(room as Room?)
            }
        }
        .pickerStyle(.navigationLink)
        .textFieldStyle()
    }
    
    var taskUserPicker: some View {
        Picker("Belongs to...", selection: $selectedUser) {
            ForEach(userViewModel.users, id: \.self) { user in
                HStack {
                    UserImage(user: user).roomUserImage
                    Text(user.wrappedUserName)
                }
                .tag(user as User?)
            }
        }
        .pickerStyle(.navigationLink)
        .textFieldStyle()
    }
    
    var taskCreateBtn: some View {
        Button {
            do {
                try taskViewModel.addTask(context: moc, title: taskTitle, category: selectedCategory, user: selectedUser, room: selectedRoom)
                dismiss()
            } catch {
                print("error")
            }
        } label: {
            Text("Create")
                .padding()
        }
        .primaryButtonStyle()
    }
}
