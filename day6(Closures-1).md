# Day 6 

## Closures-1 📖
It is a special operation similar to the assignment but functionalizing.

## Usage 🔨

### Basic Closures
```swift
let example = {
  print("Hello, I'm an example.")
}

example() // Hello, I'm an example.
```

### Accepting Parameters
```swift
// Since they are functions, of course they can take parameters.
let example = { (yourExample : String, waitWhat : String) in
  print(yourExample + waitWhat)
}

example("Haha that's my example"," We don't care about names. We use indexes.") // Haha that's my example We don't care about names. We use indexes.
```

### Returning Closures
```swift
let iReturn = { (message : String) -> String in
  return "Your message : \(message) \nI call you back." // "\n" allows jumping to the next line

}

let result = iReturn("Where are you?")
print(result) 
// Your message : Where are you? 
// I call you back.
```

### Closures as Parameters
```swift
let exampleClos = { 
    print("I'm actually parameter")
}

func funcExample(clos: () -> Void) {
    print("What?")
    clos()
}

funcExample(clos: exampleClos) // Closure is parameter now.
```

### Trailing Closure Syntax 🤯
```swift
// Remove this 
let exampleClos = { 
    print("I'm actually parameter")
}

func funcExample(clos: () -> Void) {
    print("What?")
    clos()
}

funcExample(){
  print("I'm actually parameter")
}

// This part cannot be used when there is more than one parameter.
funcExample{
  print("I'm parameter")
}

// You can use it however you want.
// But I think it's complicated and reduces readability.
```

## Tips 🤔💭

The training was too short today. I can't continue because of the rules. That's why I can't tip clues today. <br>
If anyone is interested, I'll add the source of the day here. <br>

<a href="https://www.hackingwithswift.com/100/6">Source is here</a> Happy Coding 💻
