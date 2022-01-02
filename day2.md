# Day 2

## Complex Datas And Variable Types 📖
Complex data usually refers to holding objects or lists in programming languages.

## Usage 🔨

### Arrays
```swift
// Arrays is holding multiple variables together
let player1 = "Mehmet"
let player2 = "Sait"
let player3 = "Samet"
let player4 = "Ahmet"

let players = [player1 , player2 , player3 , player4] 
```

### Sets
```swift
// Sets are very similar to arrays. They are randomly sorted and hold unique items.
let brands = Set(["BMW", "Mercedes", "AUDI"])
let brands2 = Set(["BMW", "Mercedes", "AUDI","BMW","Mercedes"])

print(brands) // [BMW,Mercedes,AUDI]
print(brands2) // [BMW,Mercedes,AUDI]
// Both outputs are the same. Sets ignore duplicate items
```

### Tuples
```swift
// Tuples are similar to lists. But it also adds an expression next to the indexes
var developer = (name: "Mehmet", surname: "Ateş")
print(developer.0) // Mehmet
print(developer.name) // Mehmet
```

### Dictionary
```swift
// Dictionaries hold values against values.
let favFood = [
    "Mehmet": "Meat",
    "Sait" : "Fried potatoes",
]

print(favFood["Sait"]) // Optional("Fried potatoes")
//             Key                      Value

// If the key is not in dictionary use default values
print(favFood["Ahmet"]) // nil
print(favFood["Ahmet",default : "Unknown"]) // Unknown
// You set safety with a default value
```

### Empty Collections
```swift
// If you want an empty collection
var numbers = Array<Int>()
var numbers2 = [Int]()

var people = [String : String]()
var people2 = Dictionary<String,String>()
// You can create however you want.

people["Mehmet"] = "Developer"
people2["Mehmet"] = "Developer"

print(people) // ["Mehmet": "Developer"] 
print(people2) // ["Mehmet": "Developer"]
```

### Enumerations
```swift
// Used to avoid different naming
let result = "success"
let result2 = "failure"

enum Result {
    case success
    case fail
}

let goodResult = Result.success
print(goodresult) // success
// So the result can take 2 different values and we don't need 2 variables for that.
```
### Enumerations Associated Values
```swift
enum Result {
    case wait
    case success(description: String)
    case fail(errorCode: Int)
}
let problem = Result.fail(errorCode : 404) 
print(problem) // fail(errorCode: 404)
// So you can keep more information.
```

### Enumerations Raw Values
```swift
// Used to match data
enum Days : Int {
    case monday = 1
    case tuesday
    case wednesday
    case thursday
}
let today = Days(rawValue: 3)
print(today) // Optional(Days.wednesday)
```

## Tips 🤔💭

### Arrays
```swift
// The index of arrays starts from 0. So the index of the first object is 0.
let player1 = "Mehmet"
let player2 = "Sait"
let player3 = "Samet"
let player4 = "Ahmet"

let players = [player1 , player2 , player3 , player4]
//                0         1         2         3

print(players[0]) // Mehmet
print(players[1]) // Sait 
print(players[4]) // This line does not give an error but will cause the program to generate a fatal error. +
// + Because the 4th object is not in the list.
```

### Sets
```swift
// If you want to work with unique objects
let uniqueObjects = Set(["Swift", "iOS", "Apple"]) // Use Sets
```

### Tuples
```swift
// Tuple types cannot be changed
var developer = (name: "Mehmet", surname: "Ateş")
var developer = (name: "Mehmet", age :20) // You can't do this. As long as this line exists, you will get an error.
```
```swift
// But its values can be changed
var developer = (name: "Mehmet", age: 20)
print(developer.1) // 20

developer.age = 21
print(developer.1) // 21
```

### Empty Collections
```swift
// You will add objects to your array later
var players = [String]() // Create a empty list with type filter.
players.append("Mehmet") // It works fine
players.append(1) // Xcode warns you and won't let you do this

var anyObject = [Any]() // If the variable type is unknown or unimportant, accept any.
// All lines works fine
anyObject.append(1)
anyObject.append("Sait")
anyObject.append(false)
```
