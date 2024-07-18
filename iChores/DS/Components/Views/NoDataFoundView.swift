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
                .foregroundColor(Color("AppPrimaryColor"))
            
            Components.DividerSpacer(height: 8)
            
            Text(dataType.noDataFoundText)
                .font(.title)
                .bold()
            
            Text(dataType.addData)
        }
        .foregroundStyle(Color("AppPrimaryColor"))
    }
}
