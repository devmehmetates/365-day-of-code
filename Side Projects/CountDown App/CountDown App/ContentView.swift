//
//  ContentView.swift
//  CountDown App
//
//  Created by Mehmet Ateş on 11.01.2022.
//

import SwiftUI

struct ContentView: View {
    let defaults = UserDefaults.standard
    let companentName = [
        "YRS",
        "DAY",
        "HRS",
        "MIN",
        "SEC"
    ]
    var componentVars : [Binding<Int>] {
        return [
            self.$year,
            self.$day,
            self.$hour,
            self.$minute,
            self.$second
        ]
    }
    @State private var remainingTime = 0
    @State private var deathDate = Date.now
    @State private var year = 0
    @State private var day = 0
    @State private var hour = 0
    @State private var minute = 0
    @State private var second = 0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var body: some View {
        VStack{
            ForEach(0..<self.companentName.count) {
                i in CounterView(count: componentVars[i], remainingTime: self.$remainingTime, title: self.companentName[i])
            }.onReceive(timer) { _ in
                if remainingTime > 0 {
                    remainingTime -= 1
                    getDeathDay()
                }
            }
        }.onAppear {
            self.getDeathDay()
        }
        
    }
    
    func getDeathDay(){
        self.deathDate = (self.defaults.object(forKey: "deathDate") ?? Date.now) as! Date
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year,.day,.hour,.minute,.second], from: Date.now, to: self.deathDate)
        
        self.year = components.year ?? 0
        self.day = components.day ?? 0
        self.hour = components.hour ?? 0
        self.minute = components.minute ?? 0
        self.second = components.second ?? 0
        
        self.remainingTime = (self.year * 31_556_926) + (self.day * 86_400) + (self.hour * 3_600) + (self.minute * 60) + (self.second * 1)
        
        if self.remainingTime == 0{
            self.remainingTime = Int.random(in: 0..<2000000000)
            self.deathDate = Date.now.addingTimeInterval(TimeInterval(remainingTime))
            self.defaults.set(self.deathDate, forKey: "deathDate")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
