//
//  ContentView.swift
//  BetterRest
//
//  Created by Mehmet Ateş on 20.04.2022.
//

import CoreML
import SwiftUI

struct ContentView: View {
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    @State private var sleepTime = Date.now
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView{
            Form{
                Text("Your ideal bedtime is \( sleepTime.formatted(date: .omitted, time: .shortened)) hour.")
                
                Section{
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                } header: {
                    Text("When do you want to wake up?")
                }
                
                Section{
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                } header: {
                    Text("Desired amount of sleep")
                }
                
                Section{
                    Picker("How many cups ?", selection: $coffeeAmount) {
                        ForEach(1..<21) { rangeAmount in
                            Button(String(rangeAmount)){ coffeeAmount = rangeAmount }
                                .foregroundColor(.primary)
                        }
                    }
                } header: {
                    Text("Daily coffee intake")
                }
                
            }.navigationTitle("BetterRest")
                .alert(alertTitle, isPresented: $showingAlert) {
                    Button("OK") { }
                } message: {
                    Text(alertMessage)
                }.onChange(of: self.coffeeAmount) { _ in
                    self.calculateBedtime()
                }.onChange(of: self.sleepAmount) { _ in
                    self.calculateBedtime()
                }.onChange(of: self.wakeUp) { _ in
                    self.calculateBedtime()
                }
        }
    }
    
    func calculateBedtime() {
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let calculatedSleepTime = wakeUp - prediction.actualSleep
            self.sleepTime = calculatedSleepTime
          
        }catch{
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
            
        }
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
