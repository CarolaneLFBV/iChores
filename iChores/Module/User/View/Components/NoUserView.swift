//
//  NoUserView.swift
//  iChores
//
//  Created by Carolane Lefebvre on 05/01/2024.
//

import SwiftUI

struct NoUserView: View {
    var body: some View {
        VStack {
            Image(systemName: "person.3")
                .font(.title)
                .foregroundColor(.gray.opacity(0.7))
            
            Spacer()
                .frame(height: 10)
            
            Text("No Users found")
                .font(.title2)
                .bold()
            
            Text("Create a new user with the + button")
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    NoUserView()
}
