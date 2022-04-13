# Day 18 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/SwiftUI/Projects/WeSplit/WeSplit"> Project </a>

## Begin to the iOS with SwiftUI
Let's start the first challenge for SwiftUI.

## Challanges

+ Add a header to the third section, saying “Amount per person”
+ Add another section showing the total amount for the check – i.e., the original amount plus tip value, without dividing by the number of people.
+ Change the tip percentage picker to show a new screen rather than using a segmented control, and give it a wider range of options – everything from 0% to 100%. Tip: use the range 0..<101 for your range rather than a fixed array.

##  Add a header to the third section, saying “Amount per person”
Yes, it is a very simple challenge indeed.
```swift
Section {
    Text(totalPerPerson, format: currenyType)
} header: {
    Text("Amount per person")
}
```

## Add another section showing the total amount for the check – i.e., the original amount plus tip value, without dividing by the number of people.
```swift
var totalTip: Double{
    let tipSelection = Double(tipPercentage)
    let tipValue = checkAmount / 100 * tipSelection
    let grandTotal = checkAmount + tipValue

    return grandTotal
}

...

Section {
    Text(totalTip, format: currenyType)
} header: {
    Text("Amount")
}
```
With a small calculation change, we can now see the amount of the tip added to the person.

## Change the tip percentage picker to show a new screen rather than using a segmented control, and give it a wider range of options – everything from 0% to 100%. Tip: use the range 0..<101 for your range rather than a fixed array.
```swift
Section {
    Picker("Tip percentage", selection: $tipPercentage) {
        ForEach(0 ..< 101, id: \.self) {
            Text($0, format: .percent)
        }
    }
} header: {
    Text("How much tip do you want to leave?")
}
```
We deleted our constant value and created it this way. We also changed the segmented view and pretended to select the same number of people.

