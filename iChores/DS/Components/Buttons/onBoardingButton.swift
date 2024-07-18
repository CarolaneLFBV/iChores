//
//  onBoardingButton.swift
//  iChores
//
//  Created by Carolane Lefebvre on 12/07/2024.
//

import SwiftUI

struct onBoardingButton: View {
    var onPress: () -> ()
    
    var body: some View {
        Button {
            onPress()
        } label: {
            HStack {
                Text("Get Started!")
                Image(systemName: "arrow.forward.circle")
            }
            .padding(.horizontal,25)
            .padding(.vertical,12)
            .background(
                Capsule().strokeBorder(lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }
}
