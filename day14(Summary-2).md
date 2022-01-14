# Day 14

## Summary-2
### Topics
+ Functions
+ Optionals
+ Optional chaining
+ Enumaretion
+ Struct
+ Classes

## Again 🔨

## Functions
```swift
func startLearn() {
  print("I'm learning now.")
}

startLearn()
```
```swift
func iLearn(what lang : String){
    print("I'm learning \(lang).")
}

iLearn(what: "Swift")
```
```swift
func tateSongs(name: String, year: Int) {
    print("\(name) was released in \(year)")
}

tateSongs(name: "Rubberband", year: 2021)
tateSongs(name: "slower", year: 2021)
tateSongs(name: "you broke me first", year: 2020)
```
```swift
func drive (_ car: String){
    print("You are driving an \(car).")
}

drive("E92")
```
```swift
func myLang(name: String) -> Bool {
    if name == "Swift" { return true }
    if name == "Dart" { return true }
    if name == "Python" { return true }
    
    return false
}

myLang(name: "Swift")
```

## Optionals
```swift
func watchMovie(for movie : String) -> String?{
    if movie == "Spider-Man" {return "Yes, Let watch"}
    
    return nil
}


watchMovie(for: "Any Movie")

watchMovie(for: "Spider-Man")

var watchStatus = watchMovie(for: "Spider-Man")

if let unwrapped = watchStatus{
    print("That's it " + unwrapped)
}else{
    print("No thanks.")
}
```
```swift
let spiderMan : String = "Spider-Man"

var status = watchMovie(for: spiderMan)

print("I am sure. \(status!)")
```

## Optional chaining
```swift
struct users {
    var name : String
    var surname : String
    var age : Int?
    var secret : String?
}

let mehmet = users(name: "Mehmet", surname: "Ateş", age: 20, secret: nil)

let userSecret = mehmet.secret ?? "Nothing"

print(userSecret)
```

## Enumaretion
```swift
enum State {
    case bored
    case happy
    case sad
}

func yourState (for state : State){
    print("Your state is \(state)")
}

yourState(for: State.happy)

func realState (for state : State) -> String?{
    if state != State.happy{
        return nil
    }else{
        return "You are happy :)"
    }
}

realState(for: .bored) ?? "Let's be happy!"
```
```swift
enum WeatherType {
    case sun
    case cloud
    case rain
    case wind(speed: Int)
    case snow
}


func getHaterStatus(weather: WeatherType) -> String? {
    switch weather {
    case .sun:
        return nil
    case .wind(let speed) where speed < 10:
        return "meh"
    case .cloud, .wind:
        return "dislike"
    case .rain, .snow:
        return "hate"
    }
}

getHaterStatus(weather: WeatherType.wind(speed: 5))
```

## Struct ⚠️
```swift
struct user {
    var name : String
    var surname : String
    var age : Int?
}

let mehmet = user(name: "Mehmet", surname: "Ateş", age: 20)

print(mehmet.name)
```
```swift
struct user {
    var name : String
    var surname : String
    var age : Int?
    
    func fullName(){
        print(name + " " + surname)
    }
}


let mehmet = user(name: "Mehmet", surname: "Ateş", age: 20)
var mehmetCopy = mehmet

mehmetCopy.name = "MehmetCopy"

print(mehmet.name)
mehmet.fullName()
print(mehmetCopy.name)
mehmetCopy.fullName()
```

## Classes ⚠️
```swift
class User {
    var name : String
    var surname : String
    var age : Int?
    
    init(name : String, surname : String, age : Int?){
        self.name = name
        self.surname = surname
        self.age = age
    }
    
    func fullName(){
        print(name + " " + surname)
    }
}

let mehmet = User(name: "Mehmet", surname: "ATEŞ", age: 20)

mehmet.name
mehmet.surname
mehmet.fullName()

class Person : User , Identifiable{
    var id = UUID()
    override func fullName() {
        print("ID :\(id) - \(name) - \(surname)")
    }
}

let mehmet2 = Person(name: "MehmetPerson", surname: "Ateş", age: 20)
mehmet2.fullName()
```

# Struct Vs Class 

## Structures have an initializer. You have to create your own for Classes
So what are these?<br>
You can create an instance from the struct and the class.<br>
You could say they are very similar. but there is quite a difference between them.To explain this.
```swift
struct Suser{
    var name : String
}
let user1 = Suser(name: "User1")
```
```swift
class Cuser{
    var name : String
    
    init(name : String){
        self.name = name
    }
}
let user2 = Cuser(name: "User2")
```

## Structure is a value type. Class is a reference type.

### If we copy "user1"
```swift
let user1 = Suser(name: "User1")
var user1Copy = user1

user1Copy.name = "User1Copy"

print(user1.name) // User1
print(user1Copy.name) // User1Copy
```
### But If we copy "user2"
```swift
let user2 = Cuser(name: "User2")
var user2Copy = user2

user2Copy.name = "User2Copy"

print(user2.name) // User2Copy
print(user2Copy.name) // User2Copy
```
The gif I've shown below also explains it visually.

<img src="https://miro.medium.com/max/940/1*N4CTsUuCT8mu7k2YlADqxQ.gif">

## Classes can inherit. Structures can't. 
We can easily use the class properties we created earlier in classes.We can add property on it and we get a new class type.
```swift
class Car {
    var brand : String
    var power : Int
    var csize : Int
    
    init(brand : String, power : Int, csize : Int){
        self.brand = brand
        self.power = power
        self.csize = csize
    }
}

class SportCar : Car{
    var spoiler : Bool
    
    init(brand : String, power : Int, csize : Int , spoiler : Bool){
        self.spoiler = spoiler
        super.init(brand: brand, power: power, csize: csize)
    }
}

let f488 = SportCar(brand: "Ferrari", power: 670, csize: 2, spoiler: true)
```



