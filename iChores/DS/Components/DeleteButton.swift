//
//  DeleteBtutton.swift
//  iChores
//
//  Created by Carolane Lefebvre on 12/02/2024.
//

import SwiftUI

struct DeleteButton: View {
    var body: some View {
        Image(systemName: "xmark.circle.fill")
            .foregroundColor(.red)
            .background(Circle().foregroundColor(.white))
            .padding(4)
    }
}

#Preview {
    DeleteButton()
}
