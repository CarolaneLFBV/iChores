//
//  BottomSheet.swift
//  iChores
//
//  Created by Carolane Lefebvre on 08/01/2024.
//

import SwiftUI

struct BottomSheetView: View {
    @State private var userViewModel = UserViewModel()
    var title: String

    var body: some View {
        ZStack {
            Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                VStack {
                    Text(title)
                        .font(.title)
                        .padding()
                    
                    Button("OK") {
                        userViewModel.isSheetPresented = false
                    }
                    .padding()
                    .primaryButtonStyle()
                }
                .background(Color.white)
                .cornerRadius(10)
                .ignoresSafeArea()
            }
        }
    }
}
