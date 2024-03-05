//
//  BottomSheet.swift
//  iChores
//
//  Created by Carolane Lefebvre on 08/01/2024.
//

import SwiftUI

struct BottomSheetView: View {
    @State var userViewModel: UserViewModel
    var title: String
    var description: String
    
    private var screenHeightSize: CGFloat {
        UIScreen.main.bounds.height
    }

    var body: some View {
        ZStack {
            Color.black.opacity(0.2).edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                VStack {
                    VStack {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .frame(width: screenHeightSize * 0.05, height: screenHeightSize * 0.05)
                            .foregroundColor(.blue)
                            .padding()
                        
                        Text(title)
                            .font(.title)
                            .bold()
                        
                        Text(description)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                    .padding()


                    
                    Button {
                        userViewModel.isSheetPresented = false
                    } label: {
                        Text("Ok")
                            .foregroundStyle(.white)
                    }
                    .primaryButtonStyle()
                    
                    Spacer()
                        .frame(height: screenHeightSize * 0.035)
                }
                .frame(maxWidth: .infinity)
                .frame(height: screenHeightSize * 0.4)
                .background(Color.white)
                .clipShape(RoundedCorner(radius: 20, corners: [.topLeft, .topRight]))

            }
            .ignoresSafeArea()
            .transition(.move(edge: .bottom))
        }
        
    }
}

#Preview {
    BottomSheetView(userViewModel: UserViewModel(), title: "User Created", description: "The user has been created")
}
