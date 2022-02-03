# Day 5 

## Functions 📖
Functions allow us to perform certain operations within a certain field. Its main use is to avoid code clutter for repetitive operations.

## Usage 🔨

### Functions Syntax
```swift
// Let's write a simple function

func helpMe () {
  print("Can I help you?")
}

helpMe() // Can I help you?

// Now every time I call helpMe(), my message will be printed on the screen.
```

### Functions with Parameters
```swift
// If you want to choose the message you want to print.

func helpMe (message : String) {
  print(message)
}

helpMe(message:"Hello print function") // Hello print function
// But that would be an unnecessary function. Because it does the same job as print function.

func fiveTime (num1 : Int){
  print(num1 * 5)
}

fiveTime(num1:5) // 25
// That makes much more sense. Because we have made a transaction.
```

### Functions Returning
```swift
// If you want to equate what you are doing with the function to a variable.
func fiveTime (num : Int) -> Int { // You need to tell in advance which type you want to return.
  return num * 5
}
let result = fiveTime(num:4)
print(result) // 20
```

### Omitting Parameter Labels
```swift
// If you want to remove parameter names.

func fiveTime (_ num : Int) -> Int { // Use _ element
  return num * 5
}
let result = fiveTime(4) // No need to enter the name "num" anymore
print(result) // 20

// However, it is not recommended for use as it reduces clarity.
```

### Default Parameters
```swift
// If you want the function to run even if no parameters are entered

func isOkay (_ okay: Bool = true) { // Use _ element
  if okay {
    print("It's okay")
  }else{
    print("It's not okay!")
  } 
}

isOkay() // It's okay
isOkay(false) // It's not okay!
// It worked without giving a parameter. When we give a parameter, the result has changed.
```

### Variadic Functions
```swift
// If the number of parameters you will enter is not clear
func calculate(numbers: Int...) {
    var result = 0
    for number in numbers {
        result += number
    }
    print("Total of numbers : \(result)")
}

calculate(numbers:1,2,3,4,5,6,7,8) // Total of numbers : 46
// I can enter as many numbers as I want.
```


### Writing Throwing Functions ⚠️
```swift
// What we're doing here is to make it return an error when the "kick" string is entered into the parameter.
// These functions are important. Because they are often useful for debugging.

enum WrongString: Error {
    case kick
}

func checkString(_ input: String) throws -> Bool {
    if input == "Kick" {
        throw WrongString.kick
    }
    return true
}

do {
    try checkString("Anyone")
    print("Have a great time")
} catch {
    print("Get Out")
}

// Have a great time
```

### Inout parameters
```swift
// If you want to change a variable as it is. So

var changeMe = 13
print(changeMe) // This output is 13. We know this.

func changeNum (_ num : inout Int){
  num = 13_000
}

changeNum(&changeMe) 
print(changeMe) // 13000

// We did not do any assignments. But we bound the variable to the function for a while.
```

## Tips 🤔💭

### Functions with Parameters
```swift
// Parameters can have 2 names.

func checkIt (check num : Int) -> Bool{
  return num > 5 
}

print(checkIt(check:6)) // true
print(checkIt(num:6)) // This line does not work. Because the parameter name is now "check".
```

### Functions Returning
```swift
// If the function will return a check result

func checkIt (num : Int) -> Bool{
  return num > 5 // Return it directly
}

print(checkIt(num:5)) // false
// If you are not going to use the return value, you should use a void function.
```
