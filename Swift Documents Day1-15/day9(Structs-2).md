# Day 9

## Structs-2 📖
Structs Part Two

## Usage 🔨

### Initializers
```swift
// Actually, initializers are like assigning a default value to the desired variable.

struct Developer {
  var name : String
}

var mehmet = Developer(name:"Mehmet") // You remember this usage
```

```swift
// Now look at the initializers
struct Developer {
  var name : String
  
  init(){ // This is init syntax
    name = "Unknown"
    print("New Developer Created")
  }
  
}

var unknownDev = Developer() // It no longer needs the parameter
```

### Referring to the current instance
```swift
// It's actually pretty easy compared to other things.

struct Developer {
  var name : String
  
  init(name:String){ // We accepted name parameter
    self.name = name // That "self.name" is equal to "var name : String" line.
  }
}

var mehmet = Developer(name:"Mehmet") 
print(mehmet.name) // Mehmet
```

### Lazy properties ✅
```swift
// It's a performance optimization
// If we want to use the variable only when we need it in the structure we created

struct StartEngine {
    init() {
        print("Engine was started.")
    }
}

struct Car {
  var power : String
  var engine = StartEngine()
  
  init (power:String){
    self.power = power
  }
}

var myCar = Car(power:"542 KW") // In this use, the engine starts as soon as you build the car. But we don't want that
```
```swift
// For this reason
struct StartEngine {
    init() {
        print("Engine was started.")
    }
}

struct Car {
  var power : String
  lazy var engine = StartEngine()
  
  init (power:String){
    self.power = power
  }
}

var myCar = Car(power:"542 KW") 
myCar.engine // Now this will happen when we want to start the engine
```


### Static properties and methods ✅
```swift
// Imagine if we actually built a car factory

struct Car {
    static var carCount = 0
    var power : String
    
    init (power:String){
        self.power = power
        Car.carCount += 1
    }
}

var myCar = Car(power: "542 KW")
var anotherCar = Car(power: "140 KW")

print(Car.carCount) // 2
// we now have a number that counts vehicles
```

### Access control 
```swift
// If we don't want the variable to be accessed

struct PrivAcc{
    var name : String
    private var posts : Int
    
    init(name : String){
        self.name = name
        self.posts = 5
    }
}

var myPrivAcc = PrivAcc(name: "Mehmet")
myPrivAcc.posts // Xcode warns us : 'posts' is inaccessible due to 'private' protection lev
```
```swift
struct PrivAcc{
    var name : String
    private var posts : Int // Now the "posts" variable can only be read within this structure.
    
    init(name : String){
        self.name = name
        self.posts = 5
    }
    
    func readPosts (){
        print("Your post count is : \(self.posts)")
    }
}

var myPrivAcc = PrivAcc(name: "Mehmet")
myPrivAcc.readPosts() // Your post count is : 5
```

## Tips 🤔💭
Since I wrote too much explanation in the usage section, I decided to remove the suggestions section. <br>
I'm thinking of making a new md file series called "compare" instead of this part. <br>
It will be a series where I will go back and repeat and compare what I have learned.<br>
See you with the "Compare" series. Happy Coding 💻
