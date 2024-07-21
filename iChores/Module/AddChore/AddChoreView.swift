import SwiftUI

struct AddChoreView: View {
    @Environment(\.dismiss) var dismiss
    @State var addChoreViewModel = AddChoreViewModel()
    @State private var choreTitle = ""
    @State private var selectedUser: User?
    @State private var selectedRoom: Room?
    
    var body: some View {
        ZStack {
            Color("AppBackgroundColor")
                .ignoresSafeArea()
            
            VStack {
                titleField
                roomPicker
                userPicker
                
                Components.DividerSpacer(height: 16)
                
                createButton
            }
            .padding()
            .task {
                addChoreViewModel.loadData()
            }
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
            Components.NoDataSelected(dataType: .room)
                .tag(nil as Room?)
            
            ForEach(addChoreViewModel.rooms, id: \.idRoom) { room in
                Components.RoomProfile(room: room, vertical: false)
                    .tag(room as Room?)
            }
        }
        .pickerStyle(.navigationLink)
        .textFieldStyle()
    }
    
    private var userPicker: some View {
        Picker("Belongs to...", selection: $selectedUser) {
            Components.NoDataSelected(dataType: .user)
                .tag(nil as User?)
            
            ForEach(addChoreViewModel.users, id: \.idUser) { user in
                Components.UserProfile(user: user, vertical: false)
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
