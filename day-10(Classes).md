# Day 10

## Classes 📖
Structs Part Two

## Usage 🔨

### Create 
```swift
// They are created like structures

class Developer{ // The only difference is the "class" keyword. For now
    var name : String
    var age : Int
    
    init(name : String, age : Int){
        self.name = name
        self.age = age
    }
}

let mehmet = Developer(name: "Mehmet", age: 20)
```

### Class inheritance
```swift
// This is important. And makes things a lot easier
class Developer{
    var name : String
    var age : Int
    var lang : String
    
    init(name : String, age : Int , lang : String){
        self.name = name
        self.age = age
        self.lang = lang
    }
}
let mehmet = Developer(name: "Mehmet", age: 20 , lang: "Swift") // Main class object

class AppleDev : Developer{ // "AppleDev" class inherits from "Developer" class
    init(name : String,age : Int){
        super.init(name: name, age: 20,lang: "Swift") // Elements are rendered to the new class object without affecting the other class.
    }
}

let mehmet2 = AppleDev(name: "Mehmet",age: 20) // Subclass object

print(mehmet2.lang)
```

### Overriding methods 
```swift
class Developer {
    func startLearn(){
        print("Learn any lang")
    }
}
class AppleDev : Developer{
}

let mehmet = AppleDev()
mehmet.startLearn() // Learn any lang
```
```swift
class AppleDev : Developer{
    override func startLearn() {
        print("Learn Swift")
    }
}
let mehmet = AppleDev()
mehmet.startLearn() // Learn Swift
```

### Final classes ✅
```swift
// Creates a class that no class can inherit.

final class Person {
    var id : Int
    var name : String
    var surname : String
    
    init(id : Int , name: String , surname: String){
        self.id = id
        self.name = name
        self.surname = surname
    }
}

let mehmet = Person(id: 0, name: "Mehmet", surname: "Ateş")

// If you try 
class SubPerson : Person{ // Inheritance from a final class 'Person'. You can't
    init(){
        super.init(id: 0, name: "Mehmet", surname: "Ateş")
    }
}
```

### Copying objects
```swift
// Objects are connected to each other. Even if we did it over a copy, its name was changed.
class Car {
    var carType = "Normal"
}

var sportCar = Car()
print(sportCar.carType) // "Normal"

var copyCar = sportCar
copyCar.carType = "Sport"

print(sportCar.carType) // "Sport"
```
```swift
// What if this was a struct. No change because the duplicate object is independent of the other
struct Car {
    var carType = "Normal"
}

var sportCar = Car()
print(sportCar.carType) // "Normal"

var copyCar = sportCar
copyCar.carType = "Sport"

print(sportCar.carType) // "Normal"
print(copyCar.carType) // "Sport"
```

### Deinitializers ✅
```swift
class Product{
    var name = "Build"
    
    init(){
        print("\(name) can be used.")
    }
    
    func everythingGood(){
        print("Everything is ok for \(name)")
    }
    
    deinit{
        print("\(name) was destroyed")
    }
}

for _ in 0...1{
    let home = Product()
    home.everythingGood()
}

// Build can be used.
// Everything is ok for Build
// Build was destroyed
// Build can be used.
// Everything is ok for Build
// Build was destroyed
```

### Mutability ✅
```swift
// Class is explicit about mutable items.

class FavoriteSinger {
    var name = "Tate Mcrae"
}

let singer = FavoriteSinger()
singer.name = "Madison Beer"
print(singer.name)
```
```swift
// If you don't want to change

class FavoriteSinger {
    let name = "Tate Mcrae" // Simply make the variable constant
}

let singer = FavoriteSinger()
singer.name = "Madison Beer" // This line gives an error
print(singer.name)
```
