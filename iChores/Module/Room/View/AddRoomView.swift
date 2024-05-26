import SwiftUI

struct AddRoomView: View {
    @Environment(\.dismiss) var dismiss
    @State var userCoreDataHelper: UserCoreDataHelper
    
    @State var addRoomViewModel: AddRoomViewModel
    
    @State private var roomName = ""
    @State private var selectedRoom = "Entrance"
    let typeRoom = ["Entrance", "Living Room", "Bedroom", "Kitchen", "Bathroom", "WC", "Garden", "Dressing Room"]
    
    @State private var selectedUser: User?
    
    var body: some View {
        VStack {
            nameField
            typePicker
            userPicker
            
            DividerSpacer(height: 40).spacer
            
            createButton
        }
        .padding()
        .task {
            try? userCoreDataHelper.fetch()
        }
    }
}

extension AddRoomView {
    private var nameField: some View {
        TextField("Room name", text: $roomName)
            .textFieldStyle()
    }
    
    private var userPicker: some View {
        Picker("Belongs to...", selection: $selectedUser) {
            NoDataSelected().noUserSelected
                .tag(nil as User?)
            
            ForEach(userCoreDataHelper.users, id: \.self) { user in
                UserProfile(user: user).horizontal
                .tag(user as User?)
            }
        }
        .pickerStyle(.navigationLink)
        .textFieldStyle()
    }
    
    private var typePicker: some View {
        Picker("Room", selection: $selectedRoom) {
            ForEach(typeRoom, id: \.self) { type in
                Text(type)
            }
        }
        .pickerStyle(.navigationLink)
        .textFieldStyle()
    }
    
    private var createButton: some View {
        Button {
            do {
                try addRoomViewModel.add(name: roomName, type: selectedRoom, user: selectedUser)
                dismiss()
            } catch {
                print("ERROR")
            }
        } label: {
            Text("Create")
                .padding()
        }
        .primaryButtonStyle()
    }
}
