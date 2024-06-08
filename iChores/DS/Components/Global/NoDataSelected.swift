import SwiftUI

extension Components {
    struct NoDataSelected: View {
        let dataType: DataType
    }
}

extension Components.NoDataSelected {
    var body: some View {
        HStack {
            Image(systemName: dataType.imageName)
                .resizable()
                .imageSizeStyle(width: 30, height: 30, contentMode: .fit)
            
            Text(dataType.noDataSelectedText)
                .font(.title3)
        }
    }
}


