//
//  DateComponentsView.swift
//  BetterRest
//
//  Created by Mehmet Ateş on 20.04.2022.
//

import SwiftUI

struct DateComponentsView: View {
    var body: some View {
        VStack{
            Text(Date.now, format: .dateTime.hour().minute())
            Text(Date.now, format: .dateTime.day().month().year())
            Text(Date.now.formatted(date: .long, time: .shortened))
        }
    }
    
    func componentsExample(){
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        var date = Calendar.current.date(from: components)
        date = Calendar.current.date(from: components) ?? Date.now
    }
    
    
    func componentsWithProperties(){
        let components = Calendar.current.dateComponents([.hour, .minute], from: Date.now)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
    }
}

struct DateComponentsView_Previews: PreviewProvider {
    static var previews: some View {
        DateComponentsView()
    }
}
