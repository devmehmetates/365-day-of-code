//
//  SplashScreenView.swift
//  MultiplicationTable
//
//  Created by Mehmet Ateş on 29.04.2022.
//

import SwiftUI
import Lottie

struct SplashScreenView: View {
    @State private var appPageCover: Bool = false
    @State private var animationOpacity: CGFloat = 0.0
    
    var body: some View {
        VStack{
            SplashAnimatedText()
            LottieAnimationView(name: "hello", loopMode: .loop)
                .frame(width: 40.0.responsizeWidth(), height: 30.0.responsizeHeight(), alignment: .center)
                .opacity(animationOpacity)
            Button {
                appPageCover.toggle()
            } label: {
                Text("Ne Duruyoruz, Öğrenelim!")
                    .frame(width: 80.0.responsizeWidth(), height: 5.0.responsizeHeight(), alignment: .center)
                    .background(.black)
                    .foregroundColor(.white)
                    .cornerRadius(50)
            }.padding(.top, 7.0.responsizeHeight())
        }.fullScreenCover(isPresented: $appPageCover, onDismiss: nil) {
            LearnPreferenceView()
        }.onAppear{
            withAnimation(.easeInOut(duration: 1.5)) {
                animationOpacity = 1
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}

struct SplashAnimatedText: View{
    @State private var textOffset: CGFloat = -100.0
    @State private var textOpacity: CGFloat = 0.0
    @State private var titleOpacity: CGFloat = 0.0
    @State private var titleOffSet: CGFloat = -50.0
    
    var body: some View{
        VStack{
            Text("Merhaba!")
                .font(.largeTitle)
                .opacity(titleOpacity)
                .offset(x: 0,y: titleOffSet)
                .padding(.bottom, 5)
            Text("Hoşgeldin, Hadi beraber çarpma tablosunu öğrenelim!")
                .multilineTextAlignment(.center)
                .opacity(textOpacity)
                .offset(y: textOffset)
        }.onAppear{
            withAnimation(.easeInOut(duration: 1.5)) {
                textOffset = 0.0
                textOpacity = 1
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        titleOpacity = 1
                        titleOffSet = 0.0
                    }
                }
            }
        }
    }
}
