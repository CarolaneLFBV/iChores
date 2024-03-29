import SwiftUI

extension Task {
    static let categoryTypeToColor: [String: Color] = [
        "Urgent and Important": Color.red,
        "Urgent but Not Important": Color.orange,
        "Not Urgent but Important": Color.yellow,
        "Not Urgent and Not Important": Color.green
    ]
    
    var categoryColor: Color {
        Self.categoryTypeToColor[self.category ?? ""] ?? Color.gray
    }
}
