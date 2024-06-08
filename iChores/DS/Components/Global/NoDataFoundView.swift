import SwiftUI

extension Components {
    struct NoDataFoundView: View {
        let dataType: DataType
    }
}

extension Components.NoDataFoundView {
    var body: some View {
        VStack {
            Image(systemName: dataType.imageName)
                .font(.title)
                .foregroundColor(.gray.opacity(0.7))
            
            Components.DividerSpacer(height: 8)
            
            Text(dataType.noDataFoundText)
                .font(.title2)
                .bold()
            
            Text("Add a room with the + button")
                .foregroundStyle(.gray)
        }
    }
}
