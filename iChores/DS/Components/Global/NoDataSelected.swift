import SwiftUI

extension Components {
    struct NoDataSelected: View {
        let dataType: DataType
        
        var body: some View {
            HStack {
                Image(systemName: dataType.imageName)
                    .resizable()
                    .imageSizeStyle(width: 30, height: 30, contentMode: .fit)
                
                Text("None")
                    .font(.title3)
            }
        }
    }
}


