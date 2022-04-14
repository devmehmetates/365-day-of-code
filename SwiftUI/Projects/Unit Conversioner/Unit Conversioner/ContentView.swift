//
//  ContentView.swift
//  Unit Conversioner
//
//  Created by Mehmet Ateş on 14.04.2022.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Changeable properties
    @FocusState private var keyboardFocus: Bool
    @State private var inputValue: Double = 0.0
    @State private var inputType: String = "Kilometers"
    @State private var resultType: String = "Meters"
    
    var calculetedValue: Double{
        return self.unitConversioner(inputValue: inputValue, convertFrom: inputType, contertTo: resultType)
    }

    // MARK: Constant properties
    let metricTypes = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]
    
    // MARK: Views
    var body: some View {
        NavigationView{
            Form{
                Section{
                    Picker("Select your type to convert", selection: self.$inputType) {
                        ForEach(self.metricTypes, id: \.self) { type in
                            Text(type)
                        }
                    }.pickerStyle(.menu)
                    
                    TextField("Enter your value", value: self.$inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($keyboardFocus)
                } header: {
                    Text("Enter the value you want to convert.")
                }
                
                Section{
                    Picker("Select your type to convert", selection: self.$resultType) {
                        ForEach(self.metricTypes, id: \.self) { type in
                            Text(type)
                        }
                    }.pickerStyle(.menu)
                    
                    Text(calculetedValue, format: .number)
                } header: {
                    Text("Result")
                }
               
                
            }.navigationTitle("Unit Conversioner")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            keyboardFocus = false
                        }
                    }
                }
        }
    }
    
    
    // MARK: Logic functions
    func unitConversioner(inputValue: Double, convertFrom: String, contertTo: String) -> Double{
        switch convertFrom{
        case "Meters":
            return self.converter(willConvertValue: Measurement(value: inputValue, unit: UnitLength.meters), convertTo: contertTo)
        case "Kilometers":
            return self.converter(willConvertValue: Measurement(value: inputValue, unit: UnitLength.kilometers), convertTo: contertTo)
        case "Feet":
            return self.converter(willConvertValue: Measurement(value: inputValue, unit: UnitLength.feet), convertTo: contertTo)
        case "Yards":
            return self.converter(willConvertValue: Measurement(value: inputValue, unit: UnitLength.yards), convertTo: contertTo)
        case "Miles":
            return self.converter(willConvertValue: Measurement(value: inputValue, unit: UnitLength.miles), convertTo: contertTo)
        default:
            return 0
        }
    }
    
    func converter(willConvertValue :Measurement<UnitLength>, convertTo: String) -> Double{
        switch convertTo{
        case "Meters":
            return willConvertValue.converted(to: .meters).value
        case "Kilometers":
            return willConvertValue.converted(to: .kilometers).value
        case "Feet":
            return willConvertValue.converted(to: .feet).value
        case "Yards":
            return willConvertValue.converted(to: .yards).value
        case "Miles":
            return willConvertValue.converted(to: .miles).value
        default:
            return 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
