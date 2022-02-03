# Day 15

## Summary-3
### Topics
+ Properties
+ Static properties and methods
+ Access control
+ Polymorphism and typecasting
+ Closures


## Again 🔨

## Properties
```swift
struct Travel {
    var rotation : String
    var time : Int
    
    func getTravel(){
        print("I will go to \(rotation) for \(time) days.")
    }
}

let myTravel = Travel(rotation: "Italy", time: 2)
myTravel.getTravel()
```
```swift
struct Travel {
    var rotation : String {
        willSet{
            updateTravel(msg: "I'm changing my rotation from \(rotation) to \(newValue) ")
        }
        didSet{
            updateTravel(msg: "I changed my rotation from \(oldValue) to \(rotation) ")
        }
    }
    var time : Int
    
    func getTravel(){
        print("I will go to \(rotation) for \(time) days.")
    }
}

func updateTravel(msg : String){
    print(msg)
}

var myTravel = Travel(rotation: "Italy", time: 2)
myTravel.rotation = "USA"
myTravel.getTravel()
```
```swift
struct Triangle {
    var edges : [Int]
    var perimeter : Int {
        get {
            var result = 0
            for i in self.edges{
                result += i
            }
            return result
        }
    }
    
}

let myTriangle = Triangle(edges: [3,4,5])
myTriangle.perimeter
```


## Static properties and methods
```swift
struct TateFan {
    static var favoriteSong = "wish i loved you in the 90s"
    
    var name: String
    var age: Int
}

let fan = TateFan(name: "Mehmet", age: 20)
print(TateFan.favoriteSong)
```

## Access control
```swift
class Till {
    private var money : Double
    
    init(money : Double){
        self.money = money
    }
}

var myTill = Till(money: 2_000_000.0)
```
```swift
class Till {
    fileprivate var money : Double
    
    init(money : Double){
        self.money = money
    }
}


var myTill = Till(money: 2_000_000.0)
myTill.money
```

## Polymorphism and typecasting
```swift
class Car {
    var brand : String
    
    init(brand : String){
        self.brand = brand
    }
}

class SportCar : Car{
    var spoiler : Bool
    
    init (brand : String, spoiler : Bool)
    {
        self.spoiler = spoiler
        super.init(brand: brand)
    }
}

class RacingCar : Car{
    var extremEngine : Bool
    
    init(brand : String, extremEngine : Bool){
        self.extremEngine = extremEngine
        super.init(brand: brand)
    }
}

var e92 = SportCar(brand: "BMW", spoiler: false)
var f488 = SportCar(brand: "Ferrari", spoiler: false)
var p918 = RacingCar(brand: "Porsche", extremEngine: true)

var garage : [Car] = [e92, f488, p918]
```
### Now let's examine this in more detail
```swift
class Car {
    var brand : String
    
    func exhaustSound(){
        print("Standart")
    }
    
    init(brand : String){
        self.brand = brand
    }
}

class SportCar : Car{
    var spoiler : Bool
    
    override func exhaustSound() {
        print("Strong")
    }
    
    init (brand : String, spoiler : Bool)
    {
        self.spoiler = spoiler
        super.init(brand: brand)
    }
}

class RacingCar : Car{
    var extremEngine : Bool
    
    override func exhaustSound() {
        print("Deafening")
    }
    
    init(brand : String, extremEngine : Bool){
        self.extremEngine = extremEngine
        super.init(brand: brand)
    }
}

var e92 = SportCar(brand: "BMW", spoiler: false)
var f488 = SportCar(brand: "Ferrari", spoiler: false)
var p918 = RacingCar(brand: "Porsche", extremEngine: true)

var garage : [Car] = [e92, f488, p918]

for car in garage {
    car.exhaustSound()
}
```
The changes we made to our inheriting classes never affected your main class. Our classes still appear in the car type.

```swift
for car in garage {
    if let sportCar = car as? SportCar{
        sportCar.exhaustSound()
    }else{
        print("Not Sport Car")
    }
}
```

### Converting common types with initializers
```swift
let number = 5

let textNumber = String(number)
```

## Closures
```swift
let vw = UIView()

UIView.animate(withDuration: 0.5, animations: {
    vw.alpha = 0
})
```
```swift
let vw = UIView()

UIView.animate(withDuration: 0.5) {
    vw.alpha = 0
}
```
