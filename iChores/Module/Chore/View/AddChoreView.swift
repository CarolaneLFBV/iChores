import SwiftUI

struct AddChoreView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State var choreViewModel: ChoreViewModel
    @State var roomViewModel: RoomViewModel
    @State var userViewModel: UserViewModel
    
    @State private var choreTitle = ""

    @State private var selectedUser: User?
    @State private var selectedRoom: Room?
    
    var body: some View {
        VStack {
            choreTextField
            choreRoomPicker
            choreUserPicker
            
            Spacer()
                .frame(height: 48)
            
            choreCreateBtn
        }
        .task {
            try? userViewModel.fetchUsers(context: moc)
            try? roomViewModel.fetchRooms(context: moc)
        }
    }
}

extension AddChoreView {
    var choreTextField: some View {
        TextField("Chore's title", text: $choreTitle)
            .textFieldStyle()
    }
    
    var choreRoomPicker: some View {
        Picker("Room", selection: $selectedRoom) {
            ForEach(roomViewModel.rooms, id: \.idRoom) { room in
                VStack {
                    Text(room.name)
                }
                .tag(room as Room?)
            }
        }
        .pickerStyle(.navigationLink)
        .textFieldStyle()
    }
    
    var choreUserPicker: some View {
        Picker("Belongs to...", selection: $selectedUser) {
            HStack {
                Image(systemName: "person.fill")
                Text("None")
            }
            .tag(nil as User?)
            
            ForEach(userViewModel.users, id: \.idUser) { user in
                HStack {
                    UserImage(user: user).roomUserImage
                    Text(user.name)
                }
                .tag(user as User?)
            }
        }
        .pickerStyle(.navigationLink)
        .textFieldStyle()
    }
    
    var choreCreateBtn: some View {
        Button {
            do {
                try choreViewModel.addChore(context: moc, title: choreTitle, user: selectedUser, room: $selectedRoom.wrappedValue)
                dismiss()
            } catch {
                print("Error Adding Chore: \(error.localizedDescription)")
            }
        } label: {
            Text("Create")
                .padding()
        }
        .primaryButtonStyle()
    }
}
