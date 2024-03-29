//
//  SecondaryButton.swift
//  iChores
//
//  Created by Carolane Lefebvre on 28/03/2024.
//

import SwiftUI

struct SecondaryButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Text("Cancel")
                .padding()
        }
        .secondaryButtonStyle()
        
    }
}

