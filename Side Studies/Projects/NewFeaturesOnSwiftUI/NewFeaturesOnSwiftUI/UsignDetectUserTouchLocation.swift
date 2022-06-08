//
//  UsignDetectUserTouchLocation.swift
//  NewFeaturesOnSwiftUI
//
//  Created by Mehmet Ateş on 7.06.2022.
//

import SwiftUI

struct UsignDetectUserTouchLocation: View {
    @State private var location: CGPoint?
    @State private var globalLocation: CGPoint?
    
    var body: some View {
        VStack{
            Circle()
                .fill(.red)
                .frame(width: 100, height: 100)
                .onTapGesture { location in
                    self.location = location
                }
            Circle()
                .fill(.red)
                .frame(width: 100, height: 100)
                .onTapGesture(coordinateSpace: .global) { location in
                    self.globalLocation = location
                }
            
            Text("X:\(location?.x ?? 0) Y:\(location?.y ?? 0)")
            Text("X:\(globalLocation?.x ?? 0) Y:\(globalLocation?.y ?? 0)")
        }
        
    }
}

struct UsignDetectUserTouchLocation_Previews: PreviewProvider {
    static var previews: some View {
        UsignDetectUserTouchLocation()
    }
}
