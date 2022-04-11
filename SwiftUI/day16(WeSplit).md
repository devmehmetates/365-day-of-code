# Day 16 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/SwiftUI/Projects/WeSplit/WeSplit"> Project </a>

## Begin to the iOS with SwiftUI

## Subjects

+ WeSplit: Introduction
+ Understanding the basic structure of a SwiftUI app
+ Creating a form
+ Adding a navigation bar
+ Modifying program state
+ Binding state to user interface controls
+ Creating views in a loop

## Summary
Greeting to all. We are on the first day of a new adventure. Even though I'm proficient in SwiftUI, I'm sure this course will teach me new things.

## WeSplit: Introduction && Understanding the basic structure of a SwiftUI app
Our topic is SwiftUI and this is definitely very different from UIKit. It has a different structure and cycle. But one of its great features is that it can be written faster and easier than UIKit. View protocol is the most important thing for SwiftUI components. Let's go ahead and look at the example.

```swift
import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
```
Example view.

## Creating a form && Adding a navigation bar
Let's start our SwiftUI codes. It's that easy to define a form.
```swift
Form{
    Text("Hello, world!")
    Text("Hello, world!")
    Text("Hello, world!")
}
```
SwiftUI has limits. Each view can have a maximum of 10 content. Because we do everything with code, SwiftUI wants to avoid confusion. This actually gives us component-based coding. If we exceed the limit, Xcode will warn us and the build will fail. To solve the problem we have to use the "Group" key. (for now)

```swift
Form{
    Section {
        Text("Hello, world!")
        Text("Hello, world!")
        Text("Hello, world!")
    }

    Section {
        Text("Hello, world!")
        Text("Hello, world!")
    }
}
```
You may have noticed the word "Section". We said Group. Section makes our code appear separate on the screen, apart from dividing it into groups. If you don't need it yes use the group key. I killed two birds with one stone!

```swift
NavigationView{
    Form{
        Section {
            Text("Hello, world!")
            Text("Hello, world!")
            Text("Hello, world!")
        }

        Section {
            Text("Hello, world!")
            Text("Hello, world!")
        }
    }.navigationTitle("Form")
        .navigationBarTitleDisplayMode(.inline)
}
```
(Embed In -> Navigation Controller) Remember this order? For UIKit this validation code above for swiftUI. Wrap the view with the NavigationView key. Done!

## Modifying program state && Binding state to user interface controls && Creating views in a loop
Our screen is a canvas. And we draw something to it with codes. What about changing values? It would be very costly to delete and redraw the picture, wouldn't it? Here is our magic word: "@State"

```swift
struct SecondSection: View {
    @State private var tabCount = 0
    @State private var name = ""
    
    var body: some View {
        Form{
            Button("Tab count: \(tabCount)"){
                self.tabCount += 1
            }
            TextField("Enter Your Name", text: $name)
            Text(name)
        }
        
    }
}
```
Looks pretty cool to use, right? And don't worry you can never run this code wrong. Try deleting the "@State" key. Xcode will tell us that the value is not suitable for mutating. We are replacing the existing value. And the "@State" saves us. Yes everything is fine but what is "$"? This "Binding" means a value. It is linked by @State and follows the value we changed with @State. Don't worry again. Xcode also says this for us.

```swift
let students = ["Harry", "Hermione", "Ron"]
@State private var selectedStudent = "Harry"

var body: some View {
    NavigationView {
        Form {
            Picker("Select your student", selection: $selectedStudent) {
                ForEach(students, id: \.self) {
                    Text($0)
                }
                // ForEach(students, id: \.self) { student in
                //  Text(student)
                // }
            }
        }
    }
}
```
Let's complicate the situation a little more. Let's have a changeable option. And let's use the Picker property. Picker is really beautiful and as can be seen Binding demands a value. ForEach? The for loop we know, but the special one for views. We used some closure features here. We got over this with the comment line. What about the id? This is related to Iterable and Hashable protocols. Don't worry, our array is a string array and strings conform to these protocols. That's why we say run the loop using our list items (ie our strings) with the "\.self" key.




