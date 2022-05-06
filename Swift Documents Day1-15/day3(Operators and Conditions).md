# Day 3 

## Operators and Conditions 📖
Operators and conditions are used to perform mathematical operations.

## Usage 🔨

### Arithmetic Operators
For 4 operations in mathematics
| Plus | Minus | Multiply | Plenty |
|-|-|-|-|
|+|-|*|/|

```swift
let num1 = 11
let num2 = 5

let total = num1 + num2 
let difference = num1 - num2
let multiply = num1 * num2
let division = num1 / num2
let remainder = num1 % num2

print(total) // 16
print(difference) // 6
print(multiply) // 55
print(division) // 2
print(remainder) // 1
```

### Operator Overloading
```swift
// This means that you can operate not only on numbers but also on other types of variables. 

let oneNum = 10
let twoNum = 10 + 10

let surname = "ATEŞ" 
let myname = "Mehmet" + " " + surname

print(myname) // Mehmet ATEŞ

// It can even be used in arrays.
let firstArray = ["First" , "Second"]
let secondArray = ["Third" , "Fourth"]

let totalArray = firstArray + secondArray

print(totalArray) // ["First", "Second", "Third", "Fourth"]
```

### Compound Assignment Operators
```swift
// This makes it easy for us to process transactions.

var step = 9999
step += 1
step = step + 1
// Both the same transaction.

// Same way
var anyText = "Devam etmesi gereken bir metin "
anyText += "her zaman devam edebilir."
```

### Comparison Operators
They are used too much and compare two values.
| Equal | Not Equal | Bigger | Less | Bigger or Equal | Less or Equal |
|-|-|-|-|-|-|
|==|!=|<|>|<=|>=|

```swift
let compareMe = 5
let compareMe2 = 4

print(compareMe == compareMe2) // false
print(compareMe != compareMe2) // true
print(compareMe < compareMe2) // false
print(compareMe > compareMe2) // true
print(compareMe <= compareMe2) // false
print(compareMe >= compareMe2) // true
```

### Conditions
Conditions are of great importance in the software world. It allows you to control the flow of the code you program.
```swift
let temperature = 9

if temperature > 20 {
    print("The weather is sunny and hot")
}else if temperature >= 10 {
    print("The weather is cloudy and warm")
}else{
    print("The weather is rainy or snowy and cold")
}

// The weather is rainy or snowy and cold
// This is the result because the value doesn't fit any comparison
```

### Combining conditions
| And | Or |
|-|-|
|&&|&#124;&#124;|
```swift
// Uses the conditions together
let age1 = 21
let age2 = 17

if age1 > 18 && age2 > 18 {
    print("You can both get a driver's license.")
}else if age1 > 18 || age2 > 18 {
    print("Only one of you can get a driver's license.")
}else{
    print("You both can't get a driver's license.")
}
// Only one of you can get a driver's license.
```

### The Ternary Operator
```swift
// Is the same as if else. Makes it harder to read but is written shorter.
let num1 = 10
let num2 = 15

var result = num1>num2 ? "First num bigger than second" : "Second num bigger than first"
print(result) // Second num bigger than first
```

### Switch Statements
```swift
// Used to control the flow of certain expressions.
let myState = "Happy"

switch myState {
case "Happy":
    print("You are look so happy!!")
case "Sad":
    print("Are you okay?")
case "Bored":
    print("Come, Let go to cinema!")
    fallthrough
default:
    print("I don't know how about your feels.")
}
// You are look so happy!!
```

### Range operators
```swift
// It is used to specify a range.
let result = 5

switch result {
case 0..<2:
    print("Bad result")
case 3..<7:
    print("Okay, but not good.")
default:
    print("Perfect!")
}
// Okay, but not good.
```

## Tips 🤔💭

### Arithmetic Operators
```swift
// If you want to do a precise calculation
let num1 = 11.0 
let num2 = 5.0 
// Use doubles

let total = num1 + num2 
let difference = num1 - num2
let multiply = num1 * num2
let division = num1 / num2

print(total) // 16.0
print(difference) // 6.0
print(multiply) // 55.0
print(division) // 2.2
```

### Operator Overloading
```swift
// Swift is a type-protected language.
let num1 = 13
let name = "Mehmet"

let total = num1 + name // So it does not allow.

let num1 = 13
let num2 = 20.0

let total = num1 + num2 // It doesn't even allow this.
let total = Double(num1) + num2 // But you can do this if you convert
print(total) // 33.0
```
```swift
// You cannot perform some operations even if they are of the same type.

var total = true + true // You can't
var total = ["It's work!", "No, you can't"] * 2 // You can't
var total = [2,5,3] * 4 // You can't
// So be careful
```

### Comparison Operators
```swift
// Swift can also compare strings
let compareMe = "Mehmet"
let compareMe2 = "Ateş"

print(compareMe == compareMe2) // false 

```

### Switch Statements
```swift
let myState = "Sad"

switch myState {
case "Happy":
    print("You are look so happy!!")
case "Sad":
    print("Are you okay?")
    fallthrough // It always runs the next condition.
case "Bored":
    print("Come, Let go to cinema!")  
default:
    print("I don't know how about your feels.")
}

// Are you okay?
// Come, Let go to cinema!
```

