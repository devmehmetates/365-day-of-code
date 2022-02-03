# Day 7

## Closures-2 📖
Part 2 of Closures

## Usage 🔨

### Using closures as parameters when they accept parameters 🤯
```swift
// First, We need a function with parameter
func tryToLearn (tryTo : (String) -> Void){ // We pass a function that takes a parameter as a parameter to the function.
   print ("Hey")
   tryTo("I tried") // used that parameter
   print("Okay")
}

// So now, the queue is the how-to run this 

tryToLearn { (whatIs: String) in
    print("What's going on. \(whatIs)") // So this line bonded to tryTo. and "whatIs" is the parameter of "tryTo"
}

// Hey
// What's going on. I tried
// Okay
```

### Using closures as parameters when they return values
```swift
// Actually it's easier to understand
func tryToLearn (tryTo : (String) -> String){ 
   print ("Hey")
   let letMeTry = tryTo("I tried") // The only difference is this line. The assignment is done because it is a return result.
   print(letMeTry)
   print("Okay")
}

// Result is the same

tryToLearn { (whatIs: String) -> String in
    return "What's going on. \(whatIs)"
}

// Hey
// What's going on. I tried
// Okay
```

### Shorthand parameter names
```swift
// Let's continue by shortening the above function
func tryToLearn (tryTo : (String) -> String){ 
   print ("Hey")
   let letMeTry = tryTo("I tried") // The only difference is this line. The assignment is done because it is a return result.
   print(letMeTry)
   print("Okay")
}

tryToLearn { (whatIs: String) -> String in
    return "What's going on. \(whatIs)"
}

// Now let's see how to write it shorter
tryToLearn { whatIs -> String in
    return "What's going on. \(whatIs)"
}

// One more. Because Swift know this closure must be return string
tryToLearn { whatIs in
    return "What's going on. \(whatIs)"
}

// One more. Because Swift know this closure must be return
tryToLearn { whatIs in
    "What's going on. \(whatIs)"
}

// And last one. Since the parameters are sequential, we can call the first parameter 0.
tryToLearn {
    "What's going on. \($0)"
}

// Every result is the same but code readability... Not sure about that.
```

### Closures with multiple parameters
```swift
// Okay lets try with multiple parameter
func tryToLearn (tryTo : (String,Int) -> String){ 
   print ("Hey")
   let letMeTry = tryTo("I tried", 13) // The only difference is this line. The assignment is done because it is a return result.
   print(letMeTry)
   print("Okay")
}

tryToLearn {
    "\($0) \($1) times."
}
 
// I also wrote another way. I think this type is best
tryToLearn { (myText,myTimes) in
     "\(myText) \(myTimes) times."
}

// Both of same

// Hey
// I tried 13 times.
// Okay
```

### Returning closures from functions 🤯x2
```swift
func clousureFunc() -> (String) -> Void { // This syntax is too confusing. But the first arrow is returned by our function.
    return { myText in
      print("clousure parameter is :  \(myText)")
    }
}

// How to use this?

let callFunc = clousureFunc()
callFunc("Tried")
// clousure parameter is :  Tried

// Or. As you wish

let callFunc2 = clousureFunc()("Tried 2")
// clousure parameter is :  Tried 2
```


### Capturing values
```swift
// This is so easy.
var funcCount = 0
func clousureFunc() -> (String) -> Void {
    var count = 0
    funcCount += 1
    print("Func called \(funcCount) times")
    return { myText in
      count += 1
      print("clousure parameter is :  \(myText) and count : \(count)")
    }
}

let result = clousureFunc()
result("One")
result("Two")
result("Three")

// Func called 1 times
// clousure parameter is :  One and count : 1
// clousure parameter is :  Two and count : 2
// clousure parameter is :  Three and count : 3

// If I call the function second time

let result2 = clousureFunc()
// It is added to the output.
// Func called 2 times 
```


## Tips 🤔💭

These issues are a bit complex and you need to make an assessment according to yourself rather than suggestions. <br>
So I leave the source link as it was yesterday. There are also several recommendations "Usage🔨". <br>

<a href="https://www.hackingwithswift.com/100/7">Source is here</a> Happy Coding 💻
