# Day 28 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/SwiftUI/Projects/BetterRest/BetterRest"> Project </a>

## Challenges

## Subjects

+ Replace each VStack in our form with a Section, where the text view is the title of the section. Do you prefer this layout or the VStack layout? It’s your app – you choose!
+ Replace the “Number of cups” stepper with a Picker showing the same range of values.
+ Change the user interface so that it always shows their recommended bedtime using a nice and large font. You should be able to remove the “Calculate” button entirely.

## Replace each VStack in our form with a Section, where the text view is the title of the section. Do you prefer this layout or the VStack layout? It’s your app – you choose!
Here we go! I really missed preparing documents. So let's take a look at today's first topic. VStack to Section. Actually, this is our topic in a nutshell.
```swift
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
```
I tried to get a nice look this way. And it was pleasant enough for me.

## Replace the “Number of cups” stepper with a Picker showing the same range of values.

```swift
Picker("How many cups ?", selection: $coffeeAmount) {
    ForEach(1..<21) { rangeAmount in
        Button(String(rangeAmount)){ coffeeAmount = rangeAmount }
            .foregroundColor(.primary)
    }
}
```
We were already using a navigation view. and there are 20 values here. I thought the default type would be fine.

## Change the user interface so that it always shows their recommended bedtime using a nice and large font. You should be able to remove the “Calculate” button entirely.
To remove this button, we need to recalculate every time a value is applied.
```swift
.onChange(of: self.coffeeAmount) { _ in
    self.calculateBedtime()
}.onChange(of: self.sleepAmount) { _ in
    self.calculateBedtime()
}.onChange(of: self.wakeUp) { _ in
    self.calculateBedtime()
}
```
This is how I did it and added a text.
```swift
@State private var sleepTime = Date.now
Text("Your ideal bedtime is \( sleepTime.formatted(date: .omitted, time: .shortened)) hour.")
```
and we had to update the inside of the function a bit.
```swift
let calculatedSleepTime = wakeUp - prediction.actualSleep
self.sleepTime = calculatedSleepTime
```
