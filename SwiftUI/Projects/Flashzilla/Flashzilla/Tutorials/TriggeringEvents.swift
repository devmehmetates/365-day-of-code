//
//  TriggeringEvents.swift
//  Flashzilla
//
//  Created by Mehmet Ateş on 20.06.2022.
//

import SwiftUI

struct TriggeringEvents: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect() 
    @State private var counter = 0

    var body: some View {
        Text("Hello, World!")
            .onReceive(timer) { time in
                if counter == 5 {
                    timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }

                counter += 1
            }
    }
}

struct TriggeringEvents_Previews: PreviewProvider {
    static var previews: some View {
        TriggeringEvents()
    }
}
