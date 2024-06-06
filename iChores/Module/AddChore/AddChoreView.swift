import SwiftUI

struct AddChoreView: View {
    @Environment(\.dismiss) var dismiss
    @State var addChoreViewModel = AddChoreViewModel()
    @State private var choreTitle = ""
    @State private var selectedUser: User?
    @State private var selectedRoom: Room?
    
    var body: some View {
        VStack {
            titleField
            roomPicker
            userPicker
            
            DividerSpacer(height: 16)
            
            createButton
        }
        .padding()
        .task {
            addChoreViewModel.loadData()
        }
    }
}

extension AddChoreView {
    private var titleField: some View {
        TextField("Chore's title", text: $choreTitle)
            .textFieldStyle()
    }
    
    private var roomPicker: some View {
        Picker("Room", selection: $selectedRoom) {
            NoDataSelected().noRoomSelected
                .tag(nil as Room?)
            
            ForEach(addChoreViewModel.rooms, id: \.idRoom) { room in
                RoomProfile(room: room, vertical: false)
                    .tag(room as Room?)
            }
        }
        .pickerStyle(.navigationLink)
        .textFieldStyle()
    }
    
    private var userPicker: some View {
        Picker("Belongs to...", selection: $selectedUser) {
            NoDataSelected().noUserSelected
                .tag(nil as User?)
            
            ForEach(addChoreViewModel.users, id: \.idUser) { user in
                UserProfile(user: user).horizontal
                    .tag(user as User?)
            }
        }
        .pickerStyle(.navigationLink)
        .textFieldStyle()
    }
    
    private var createButton: some View {
        Button {
            addChoreViewModel.add(title: choreTitle, user: selectedUser, room: $selectedRoom.wrappedValue)
            dismiss()
        } label: {
            Text("Create")
                .padding()
        }
        .primaryButtonStyle()
    }
}
