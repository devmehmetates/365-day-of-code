//
//  CoreMotionView.swift
//  Deneme
//
//  Created by Mehmet Ateş on 05.08.2022.
//

import SwiftUI
import CoreMotion

struct CoreMotionView: View {
    @State private var offsetX: CGFloat = 0.0
    @State private var offsetY: CGFloat = 0.0
    var motionManager: CMMotionManager = CMMotionManager()
    
    var body: some View {
        VStack {
            Text((motionManager.accelerometerData?.acceleration.x ?? 0).formatted())
            Text((motionManager.accelerometerData?.acceleration.y ?? 0).formatted())
            Circle()
                .frame(width: 50, height: 50)
                .position(x: 25, y: 25)
                .offset(x: offsetX, y: offsetY)
        }.frame(width: 300, height: 300)
            .background(.red)
        #if targetEnvironment(simulator)
            .onTapGesture() { location in
                withAnimation {
                    if location.x > 275 {
                        offsetX = 250
                    } else {
                        offsetX = location.x - 25
                    }
                    
                    if location.x < 25 {
                        offsetX = 50
                    } else {
                        offsetX = location.x - 25
                    }
                    
                    if location.y > 275 {
                        offsetY = 250
                    } else {
                        offsetY = location.y - 25
                    }
                    
                    if location.y < 25 {
                        offsetY = 50
                    } else {
                        offsetY = location.y - 25
                    }
                    
                }
            }
        #else
            .onChange(of: motionManager.accelerometerData) { newValue in
                offsetX = CGFloat(motionManager.accelerometerData?.acceleration.x ?? 0)
                offsetY = CGFloat(motionManager.accelerometerData?.acceleration.y ?? 0)
            }
            .onAppear{
                motionManager.startDeviceMotionUpdates()
                motionManager.startAccelerometerUpdates()
            }
        #endif
    }
}

struct CoreMotionView_Previews: PreviewProvider {
    static var previews: some View {
        CoreMotionView()
    }
}
