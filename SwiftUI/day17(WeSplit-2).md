# Day 17 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/SwiftUI/Projects/WeSplit/WeSplit"> Project </a>

## Begin to the iOS with SwiftUI
Hello! I'm here with a wonderful day. Let's start.

## Subjects

+ Reading text from the user with TextField
+ Creating pickers in a form
+ Adding a segmented control for tip percentages
+ Calculating the total per person
+ Hiding the keyboard

##  Reading text from the user with TextField && Creating pickers in a form
We will actually go over what we used in the previous lesson. And we're going to put them in a more organized state.
```swift
@State private var checkAmount = 0.0
@State private var numberOfPeople = 2
@State private var tipPercentage = 20

TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
  .keyboardType(.decimalPad)
```
As you can see, there is not much difference. But there are really effective changes. It warns you if you normally want to enter a double in a textfield. To prevent this, we specify that we will enter a value for it. Besides that we even tell what format the value is in.I know we have new information compared to the other course, but they are very simple.

+ Locale.current: The call here varies depending on the region on our current device.
+ Locale.current.currencyCode: This means currency value for us. So like USD, TL, EURO.
+ keyboardType: I think you got it from the name, but let me state it anyway. This is how we can determine our keyboard type.

```swift
Picker("Number of people", selection: $numberOfPeople) {
    ForEach(2 ..< 100) {
        Text("\($0) people")
    }
}
```
Even though the output of this part looks really messy, it's okay. Because this code will not work inside the form. It will behave like a text. To resolve this we have to wrap the form in navigation view.

```swift
NavigationView {
    Form{
        Section{
            TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                .keyboardType(.decimalPad)
                .focused($amountIsFocused)

            Picker("Number of people", selection: $numberOfPeople) {
                ForEach(0 ..< 100) {
                    Text("\($0) people")
                }
            }
        }
    }.navigationTitle("WeSplit")
}
```
Now this is a working picker. And as an extra, now that our page is a navigation view, we can use the feature we learned yesterday.


## Adding a segmented control for tip percentages && Calculating the total per person
Ok, let's move on to a new chapter. We now have a number of people and a fee entry. Now it's tip time!
```swift
Section {
    Picker("Tip percentage", selection: $tipPercentage) {
        ForEach(tipPercentages, id: \.self) {
            Text($0, format: .percent)
        }
    }.pickerStyle(.segmented)
} header: {
    Text("How much tip do you want to leave?")
}
```
Hey, that's even more complicated! Let's explain. SwiftUI provides really nice features for us. See how often we changed the "pickerStyle". A tiny piece of code! The part about the Section is much simpler. If you are interested in web programming, you are familiar with the concepts of footer and header. If you're not, no problem. Go with their names. They mean texts placed at the beginning and at the end. And they look really flawless.

Let's calculate.
```swift
var totalPerPerson: Double {
    let peopleCount = Double(numberOfPeople + 2)
    let tipSelection = Double(tipPercentage)

    let tipValue = checkAmount / 100 * tipSelection
    let grandTotal = checkAmount + tipValue
    let amountPerPerson = grandTotal / peopleCount

    return amountPerPerson
}
```
Closures are really special things in Swift. And that's one of its features. This Syntax allows us to create variables with read-only values. Then it's great! We've done our calculations and note that our values taken into account are @State values. This is important because there are parts of our screen that are redrawn when our value changes. And this effect is invaluable.

```swift
Section {
    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "USD"))
}
```
Text version of the value we entered above. So no binding is needed. If it changes it will be redrawn.

##  Hiding the keyboard
Here is the part of the day that is new to me too! New informations. BOOM!!!

```swift
@FocusState private var amountIsFocused: Bool

// Our TextfieldCodes
.focused($amountIsFocused)
```
Focus code. It allows us to affect a certain state focus. For example the keyboard focus on the textfield. The value we define with this keyword will serve this purpose. And notice that there is a binding.

```swift
.toolbar {
    ToolbarItemGroup(placement: .keyboard) {
        Spacer()

        Button("Done") {
            amountIsFocused = false
        }
    }
}
```
To be honest, I've used the toolbar many times. But I didn't know it had such a use. It is used for a series of content that sticks to the keyboard and appears with it. As you can see here, we set our focus value to false and break the keyboard focus. We hide the keyboard as well!


