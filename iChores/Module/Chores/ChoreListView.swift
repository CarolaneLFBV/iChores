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
            
            ScrollView {
                choreList
            }
        }
    }
}

extension ChoreListView {
    private var choreList: some View {
        VStack {
            if choreListViewModel.chores.isEmpty {
                Components.NoDataFoundView(dataType: .chore)
            } else {
                lazyGridView
            }
        }
    }
    
    private var lazyGridView: some View {
        LazyVGrid(columns: columns) {
            ForEach(choreListViewModel.chores, id: \.idChore) { chore in
                Text(chore.title)
            }
        }
    }
}
