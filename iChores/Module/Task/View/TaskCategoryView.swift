import SwiftUI

struct TaskCategoryView: View {
    let chore: Task
    
    var body: some View {
        Text(chore.wrappedTaskCategory)
            .foregroundStyle(chore.categoryColor)
    }
}
