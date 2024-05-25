import SwiftUI

struct ChoreRowView: View {
    let chore: Chore
    var choreViewModel: ChoreViewModel

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "checkmark.square")
                Text(chore.title)
                Spacer()
                Text(chore.choreToRoom.name)
            }
            .padding(.all, 4)
            .onTapGesture {
                do {
                    try choreViewModel.markChoreAsDoneAndDelete(chore)
                } catch {
                    print("error")
                }
            }
        }
    }
}

