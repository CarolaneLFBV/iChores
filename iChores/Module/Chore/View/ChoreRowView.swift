import SwiftUI

struct ChoreRowView: View {
    let chore: Chore
    var choreViewModel: ChoreViewModel
    @Environment(\.managedObjectContext) var moc

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
                    try choreViewModel.deleteChore(chore)
                } catch {
                    print("error")
                }
            }
        }
    }
}

