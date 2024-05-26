import SwiftUI

struct AddChoreView: View {
    @Environment(\.dismiss) var dismiss
    @State var userCoreDataHelper: UserCoreDataHelper
    @State var roomCoreDataHelper: RoomCoreDataHelper

    @State var addChoreViewModel: AddChoreViewModel
    
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
            try? userCoreDataHelper.fetch()
            try? roomCoreDataHelper.fetch()
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
            
            ForEach(roomCoreDataHelper.rooms, id: \.idRoom) { room in
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
            
            ForEach(userCoreDataHelper.users, id: \.idUser) { user in
                UserProfile(user: user).horizontal
                    .tag(user as User?)
            }
        }
        .pickerStyle(.navigationLink)
        .textFieldStyle()
    }
    
    private var createButton: some View {
        Button {
            do {
                try addChoreViewModel.add(title: choreTitle, user: selectedUser, room: $selectedRoom.wrappedValue)
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
