import SwiftUI

struct AddRoomView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State var roomViewModel: RoomViewModel
    @State var userViewModel: UserViewModel
    
    @State private var roomName = ""
    @State private var selectedRoom = "Entrance"
    let typeRoom = ["Entrance", "Living Room", "Bedroom", "Kitchen", "Bathroom", "WC", "Garden", "Dressing Room"]
    
    @State private var selectedUser: User?
    
    var body: some View {
        VStack {
            roomNameField
            roomTypePicker
            roomUserPicker
            
            Spacer()
                .frame(height: 48)
            
            roomCreateBtn
        }
        .onAppear {
            try? userViewModel.fetchUsers(context: moc)
        }
    }
}

extension AddRoomView {
    // MARK: - roomNameField
    var roomNameField: some View {
        TextField("Room name", text: $roomName)
            .textFieldStyle()
    }
    
    // MARK: - roomUserPicker
    var roomUserPicker: some View {
        Picker("Belongs to...", selection: $selectedUser) {
            HStack {
                Image(systemName: "person.fill")
                Text("None")
            }
            .tag(nil as User?)
            
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
    
    // MARK: - roomTypePicker
    var roomTypePicker: some View {
        Picker("Room", selection: $selectedRoom) {
            ForEach(typeRoom, id: \.self) { type in
                Text(type)
            }
        }
        .pickerStyle(.navigationLink)
        .textFieldStyle()
    }
    
    // MARK: - roomCreateBtn
    var roomCreateBtn: some View {
        Button {
            do {
                try roomViewModel.addRoom(context: moc, name: roomName, type: selectedRoom, user: selectedUser)
            } catch {
                print("ERROR")
            }
        } label: {
            Text("Create")
                .foregroundStyle(.white)
        }
        .primaryButtonStyle()
        .frame(maxWidth: .infinity)

    }
}
