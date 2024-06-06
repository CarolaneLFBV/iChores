import SwiftUI

struct ChoreRowView: View {
    let chore: Chore
    var editChoreViewModel = EditChoreViewModel()

    var body: some View {
        VStack {
            HStack {
                Image(systemName: chore.isDone ? "checkmark.square" : "square")
                Text(chore.title)
                Spacer()
                Text(chore.choreToRoom.name)
            }
            .padding(.all, 4)
        }
    }
}

