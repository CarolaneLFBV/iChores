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
                      .frame(width: 200)
                      .shadow(color: Color(red: 0, green: 0, blue: 0), radius: 3,x:2,y:2)
                  
                  Text(onBoardingItem.title)
                      .fontWeight(.heavy)
                      .font(.system(size: 40))
                      .multilineTextAlignment(.center)
                  
                  Text(onBoardingItem.headline)
                      .fontWeight(.light)
                      .font(.system(size: 18))
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
              .background(onBoardingItem.backgroundColor)
          }
    }
}

#Preview {
    OnBoardingView(onBoardingItem: OnBoardingItem(title: "Title", headline: "Headline", image: "cleaning", backgroundColor: Color("AppBackgroundColor")), isLastItem: true)
}
