import SwiftUI

struct ChoreListView: View {
    @State var choreListViewModel = ChoreListViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ZStack {
            Color("AppBackgroundColor")
                .ignoresSafeArea()
            
            choreOptions
                .task {
                    choreListViewModel.loadData()
                }
        }
        .navigationTitle("Chores")
    }
}

extension ChoreListView {
    private var choreOptions: some View {
        VStack {
            if choreListViewModel.chores.isEmpty {
                Components.NoDataFoundView(dataType: .chore)
            } else {
                choreList
            }
        }
    }
    
    private var choreList: some View {
        ScrollView {
            ForEach(choreListViewModel.chores, id: \.idChore) { chore in
                ChoreRowView(chore: chore)
            }
        }
    }
}
