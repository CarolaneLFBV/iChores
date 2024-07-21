import SwiftUI

struct AddRoomView: View {
    @Environment(\.dismiss) var dismiss
    @State private var addRoomViewModel = AddRoomViewModel()
    @State private var roomName = ""
    @State private var selectedRoom = "Entrance"
    let typeRoom = ["Entrance", "Living Room", "Bedroom", "Kitchen", "Bathroom", "WC", "Garden", "Dressing Room"]
    
    @State private var selectedUser: User?
    
    var body: some View {
        ZStack {
            Color("AppBackgroundColor")
                .ignoresSafeArea()

            VStack(alignment: .leading) {
                nameField
                typePicker
                userPicker
                
                Components.DividerSpacer(height: 40)
                
                createButton
            }
            .padding()
            .task {
                addRoomViewModel.loadData()
            }
        }
    }
}

extension AddRoomView {
    private var nameField: some View {
        TextField("Room name", text: $roomName)
            .textFieldStyle()
    }
    
    private var userPicker: some View {
        HStack {
            Text("Belongs to...")
            
            Spacer()
            
            Picker("Pick a user", selection: $selectedUser) {
                Components.NoDataSelected(dataType: .user)
                    .tag(nil as User?)
                
                ForEach(addRoomViewModel.users, id: \.idUser) { user in
                    Components.UserProfile(user: user, vertical: false)
                        .tag(user as User?)
                }
            }
        }
        .textFieldStyle()
        .foregroundStyle(Color("AppPrimaryColor"))
    }
    
    private var typePicker: some View {
        HStack {
            Text("Type of Room")
            
            Spacer()
            
            Picker("Type of Room", selection: $selectedRoom) {
                ForEach(typeRoom, id: \.self) { type in
                    Text(type)
                }
            }
        }
        .textFieldStyle()
        .foregroundStyle(Color("AppPrimaryColor"))
    }
    
    private var createButton: some View {
        Button {
            addRoomViewModel.add(name: roomName, type: selectedRoom, user: selectedUser)
            dismiss()
        } label: {
            Text("Create")
                .padding()
        }
        .primaryButtonStyle()
    }
}
