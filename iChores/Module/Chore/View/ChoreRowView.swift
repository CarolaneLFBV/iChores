import SwiftUI

struct ChoreRowView: View {
    let chore: Chore
    
    var body: some View {
        HStack {
            Text(chore.title)
            Spacer()
            Text("\(chore.choreToRoom.name)")
        }
    }
}

