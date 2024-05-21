import SwiftUI

struct NoDataSelected: View {
    var body: some View {
        noRoomSelected
    }
    
    var noRoomSelected: some View {
        HStack {
            Image(systemName: "square.split.bottomrightquarter")
                .resizable()
                .imageSizeStyle(width: 30, height: 30, contentMode: .fit)
            
            Text("None")
                .font(.title3)
        }
    }
    
    var noUserSelected: some View {
        HStack {
            Image(systemName: "person.fill")
                .resizable()
                .imageSizeStyle(width: 30, height: 30, contentMode: .fit)

            Text("None")
                .font(.title3)
            
        }
    }
}

#Preview {
    NoDataSelected()
}
