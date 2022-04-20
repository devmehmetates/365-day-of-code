//
//  DatePickersView.swift
//  BetterRest
//
//  Created by Mehmet Ateş on 20.04.2022.
//

import SwiftUI

struct DatePickersView: View {
    @State private var wakeUp = Date.now
    
    var body: some View {
        VStack{
            DatePicker("Please enter a date", selection: $wakeUp)
            DatePicker("", selection: $wakeUp)
            DatePicker("Please enter a date", selection: $wakeUp)
                .labelsHidden()
            DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
            DatePicker("Please enter a date", selection: $wakeUp, in: Date.now...) // past time is closed now
        }.padding()
    }
}


struct DatePickersView_Preview: PreviewProvider {
    static var previews: some View {
        DatePickersView()
    }
}
