# Day 8

## Structs 📖
Now we have taken a step towards very important issues. Because today we will learn about structs, which is the essence of programming.

## Usage 🔨

### Create a basic struct
```swift
// In this part, we are now transitioning to a little more object-oriented programming.
struct ProgrammingLang { // Like this syntax closures. But the "struct" keyword changes everything
    var name : String
    var creator : String
}

var lang1 = ProgrammingLang(name: "Swift", creator: "Apple") // We now have a programming language object

// And the properties that that object has
print(lang1.name) // Swift
print(lang1.creator) // Apple

// And If you want to change any value of that object. You can
lang1.name = "Dart"
lang1.creator = "Google"

print(lang1.name) // Dart
print(lang1.creator) // Google
```

### Computed properties
```swift
// We can request a value to be calculated for us inside this object.
struct ProgrammingLang {
    var name : String
    var creator : String
    var isOpenSource : Bool
    
    // This value is calculated according to the other variable given
    var openSourceStatus : String{
      if isOpenSource {
        return "Yes, this lang is open source"
      }else{
        return "No, sorry this lang is not open source"
      }
    }
}

var lang1 = ProgrammingLang(name: "Swift", creator: "Apple",isOpenSource : true)
print(lang1.openSourceStatus) // Yes, this lang is open source
```

### Property observers ✅
```swift
// If you want to be notified when the value of a variable changes
struct GamePatch {
    var name : String
    var patch : String {
      didSet {
            print("\(name) currently \(patch) patch")
        }
    }
}

var game1 = GamePatch(name:"League of Legends" , patch : "11.23")
// The transaction takes place as soon as the value changes.
game1.patch = "11.24" // League of Legends currently 11.24 patch
```

### Methods
Of course, these objects can have functions in them.
```swift
struct Triangle {
  var base : Double
  var height : Double
  
  func calculateArea() -> Double{
    return (self.base * self.height) / 2
  }
}

let triangle1 = Triangle(base:10 , height:5)
let triangle1Area = triangle1.calculateArea()
print(triangle1Area) // 25
```


### Mutating methods ✅
```swift
struct Person {
  var name : String
  
  mutating func secret() {
    name = "Top Secret"
  }
}

var anyPerson = Person(name:"Important")
print (anyPerson.name) // Important
anyPerson.secret()
print (anyPerson.name) // Top Secret

// If we remove "mutating", We get an error like this. And a suggestion
// error: cannot assign to property: 'self' is immutable
// note: mark method 'mutating' to make 'self' mutable 
```

## Properties and methods of Strings and Arrays 📖

## Usage 🔨

### Strings
```swift
let iAmString =  "what are my properties" 

print(iAmString.count) // Returns the length of our text

print(iAmString.hasPrefix("what")) // Checks if it starts with the string we entered

print(iAmString.uppercased()) // Returns the string in capital letters

print(iAmString.sorted()) // Returns all characters in the string as an ordered list.
```

### Arrays
```swift
var myDreamCars = ["E92"]

print(myDreamCars.count) // Returns the length of our array

myDreamCars.append("718 Cayman GTS") // adds an item to the array 
myDreamCars.append("911 Turbo S")

print(myDreamCars.firstIndex(of: "911 Turbo S")) // Returns the first index of the element in the array

print(myDreamCars.sorted()) // sorts and returns array

myDreamCars.remove(at: 2) // Deletes item in 2nd index

print(myDreamCars) // ["E92", "718 Cayman GTS"] 
```

## Tips 🤔💭

We have come to the end of a good topic. Unfortunately, there is no clue to tell today either. <br>
Because when explaining the subjects, I explain with certain suggestions. <br>
But in the coming days, I will prepare a nice suggestion section about "class vs struct" for the struct topic. <br>
That was it for today. Happy Coding 💻
