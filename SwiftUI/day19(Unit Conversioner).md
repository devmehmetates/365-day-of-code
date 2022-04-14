# Day 19 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/SwiftUI/Projects/Unit%20Conversioner/Unit%20Conversioner"> Project </a>

## Begin to the iOS with SwiftUI

## Challenges 

+ A segmented control for meters, kilometers, feet, yard, or miles, for the input unit.
+ A second segmented control for meters, kilometers, feet, yard, or miles, for the output unit.
+ A text field where users enter a number.
+ A text view showing the result of the conversion.

## All views in here
```swift
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
``` 
Yes, it's time to use the features we learned from previous lessons. As a Picker type, the menu seemed more pleasant to me. That's why I chose it. In addition, our format type is currently .number.

## Logic && properties
```swift
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
```
As a result of a little research, I found the features that swift offers us instead of arithmetic operations. Using these will definitely look cleaner. I wrote 2 functions according to the metric types and the values they want to convert.

```swift
@FocusState private var keyboardFocus: Bool
@State private var inputValue: Double = 0.0
@State private var inputType: String = "Kilometers"
@State private var resultType: String = "Meters"

var calculetedValue: Double{
    return self.unitConversioner(inputValue: inputValue, convertFrom: inputType, contertTo: resultType)
}

let metricTypes = ["Meters", "Kilometers", "Feet", "Yards", "Miles"]
```
These are our variables that govern our choices, our focus, and our inputs and outputs.

## App
<div>
  <img src="https://user-images.githubusercontent.com/74152011/163458289-027ab4ad-89ae-4f4a-aafa-4ba1a507411b.png" width=260>
  <img src="https://user-images.githubusercontent.com/74152011/163458305-d838b6fa-0eb6-4572-8dcc-f6de21df3fa7.png" width=260>
</div>


