import SwiftUI

struct ChoreUserAssignView: View {
    @State private var choreUserViewModel = ChoreUserAssignViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ZStack {
            Color("AppBackgroundColor")
                .ignoresSafeArea()
            
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    ForEach(choreUserViewModel.users, id: \.idUser) { user in
                        Components.UserProfile(user: user, vertical: true)
                    }
                })
            }
        }
        .task {
            choreUserViewModel.loadData()
        }
    }
}
