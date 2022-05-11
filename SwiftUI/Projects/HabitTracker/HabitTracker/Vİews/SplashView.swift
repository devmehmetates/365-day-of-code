//
//  SplashView.swift
//  HabitTracker
//
//  Created by Mehmet Ateş on 11.05.2022.
//

import SwiftUI

struct SplashView: View {
    @State private var isLoaded: Bool = false
    @State private var progressbarValue: Float = 0
    
    var body: some View {
        VStack{
            Text("Habit Tracker")
                .font(.largeTitle)
                .fontWeight(.ultraLight)
            LottieAnimationView(name: "splash", loopMode: .loop)
                .frame(width: 100.0.responsiveW, height: 50.0.responsiveH, alignment: .center)
            VStack{
                Text("Loading...")
                ProgressView(value: progressbarValue, total: 100)
                    .padding()
            }
        }.onAppear{
            withAnimation(.easeInOut(duration: 1.5)) {
                progressbarValue = 100
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.isLoaded = true
            }
        }
        .fullScreenCover(isPresented: $isLoaded) {
            DashboardView()
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
