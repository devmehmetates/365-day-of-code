//
//  StepperView.swift
//  BetterRest
//
//  Created by Mehmet Ateş on 20.04.2022.
//

import SwiftUI

struct StepperView: View {
    @State private var sleepAmount = 8.0
    
    var body: some View {
        VStack{
            Stepper("\(sleepAmount) hours", value: $sleepAmount)
            Stepper("\(sleepAmount) hours", value: $sleepAmount,  in: 4...12)
            Stepper("\(sleepAmount) hours", value: $sleepAmount,  in: 4...12, step: 0.25)
            Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount,  in: 4...12, step: 0.25)
        }.padding()
    }
}

struct StepperView_Previews: PreviewProvider {
    static var previews: some View {
        StepperView()
    }
}
