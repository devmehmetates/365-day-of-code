//
//  CounterView.swift
//  CountDown App
//
//  Created by Mehmet Ateş on 13.01.2022.
//

import SwiftUI

struct CounterView: View {
    @Binding var count : Int
    @Binding var remainingTime : Int
    let countProcess = CountProcess()
    let title : String
    var body: some View{
        
        HStack(alignment:.lastTextBaseline,spacing: 0){
            
            Text(self.countProcess.CountVisual(count: self.count))
                .font(.system(size: 90))
                .fontWeight(.bold)
            
            Text(self.title)
                .fontWeight(.bold)
            
        }.foregroundColor(self.countProcess.isCountDone(which: self.title, for: self.remainingTime) ? .red : .primary)
    }
}
