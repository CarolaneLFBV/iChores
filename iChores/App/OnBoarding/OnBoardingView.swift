//
//  OnBoardingView.swift
//  iChores
//
//  Created by Carolane Lefebvre on 12/07/2024.
//

import SwiftUI

struct OnBoardingView: View {
    var onBoardingItem: OnBoardingItem
    var isLastItem: Bool
    @AppStorage("isOnBoarding") var isOnBoarding: Bool = true
    
    var body: some View {
        ZStack {
              VStack(spacing:20){
                  Image(onBoardingItem.image)
                      .resizable()
                      .scaledToFit()
                      .shadow(color: Color(red: 0, green: 0, blue: 0), radius: 3,x:2,y:2)
                  
                  Text(onBoardingItem.title)
                      .fontWeight(.heavy)
                      .font(.system(size: 50))
                      .foregroundColor(.white)
                  
                  Text(onBoardingItem.headline)
                      .fontWeight(.light)
                      .font(.system(size: 18))
                      .foregroundColor(.white)
                      .padding(.bottom,15)
                      .multilineTextAlignment(.center)
                  
                  if isLastItem {
                      onBoardingButton(onPress: {
                          isOnBoarding = false
                      })
                  }
              }
              .padding(.horizontal,15)
              .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .center)
              .background(
                  LinearGradient(colors: onBoardingItem.gradientColors, startPoint: .top, endPoint: .bottom)
              )
          }
    }
}
