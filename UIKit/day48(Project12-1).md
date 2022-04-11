# Day 48 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day48-49/Day42-44"> Project </a>

## Developing on UserDefaults and NSCoder

## Subjects

+ Set-Up
+ Reading and writing basics: UserDefaults
+ Fixing Project 10: NSCoding


## Reading and writing basics: UserDefaults
### <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day48(UserDefault)/Day48(UserDefault)">Project</a>
Let me give you a simple example and skip this part. You can use the project link for the remaining examples.

```swift
var name = "Mehmet"
let defaults = UserDefaults.standart
defaults.set(name, forKey: "name")
let savedName = defaults.object(forKey:"name") as? String ?? ""
```

## Fixing Project 10: NSCoding
We will open the object we received with NSCoding
```swift
class Person: NSObject, NSCoding {
    var name : String
    var image : String
    
    init (name : String, image : String){
        self.name = name
        self.image = image
    }
    
    required init?(coder: NSCoder) {
        name = coder.decodeObject(forKey: "name") as? String ?? ""
        image = coder.decodeObject(forKey: "image") as? String ?? ""
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(image, forKey: "image")
    }
}
```
Here we have registered a number of people in our app.
```swift
func save(){
    if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: people, requiringSecureCoding: false){
        let defaults = UserDefaults.standard
        defaults.set(savedData, forKey: "people")
    }
}
```
And of course we did this after the insertion process.
```swift
...
let person = Person(name: "Unknow", image: imageName)
people.append(person)
save()
...
```
```swift
...
guard let newName = sac?.textFields?[0].text else { return }
person.name = newName
self?.save()
...
```
Next is to decode while loading
```swift
let defaults = UserDefaults.standard
if let savedPeople = defaults.object(forKey: "people") as? Data{
    if let decodedPeople = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedPeople) as? [Person]{
        people = decodedPeople
    }
}
```




## Happy Coding :)

<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">

