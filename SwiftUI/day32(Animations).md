# Day 16 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/SwiftUI/Projects/WeSplit/WeSplit"> Project </a>

## Animations with SwiftUI

## Subjects

+ Animation: Introduction
+ Creating implicit animations
+ Customizing animations in SwiftUI
+ Animating bindings
+ Creating explicit animations

## Creating implicit animations && Customizing animations in SwiftUI
Hello. We are together with a new application that we learned and then applied. Our topic is animations. Let's dive.

```swift
@State private var animationAmount = 1.0

Button("Tap Me!"){
// animationAmount += 1
}.padding(50)
.background(.red)
.foregroundColor(.white)
.clipShape(Circle())
.overlay(
    Circle()
        .stroke(.red)
        .scaleEffect(animationAmount)
        .opacity(2 - animationAmount)
        .animation(
            .easeOut(duration: 1)
            .repeatForever(autoreverses: false),
            value: animationAmount
        )
).onAppear {
    animationAmount = 2
}
// .animation(
// .easeInOut(duration: 1)
// .repeatForever(autoreverses: true),
//    value: animationAmount
// )
// .animation(
// .easeInOut(duration: 1)
// .repeatCount(3, autoreverses: true),
//    value: animationAmount
// )
// .animation(
//    .easeInOut(duration: 2)
//    .delay(1),
//    value: animationAmount
// )
// .animation(.easeInOut(duration: 2), value: animationAmount)
// .animation(.interpolatingSpring(stiffness: 50, damping: 1), value: animationAmount)
// .animation(.default, value: animationAmount)
```
We have plenty of animation examples available in this code snippet. It is really easy to use and very effective.

## Animating bindings
```swift
@State private var animationAmount = 1.0

VStack {
    Stepper("Scale amount", value: $animationAmount.animation(
        .easeInOut(duration: 1)
        .repeatCount(1, autoreverses: true)
    ), in: 1...10)

    Spacer()

    Button("Tap Me") {
        animationAmount += 1
    }
    .padding(40)
    .background(.red)
    .foregroundColor(.white)
    .clipShape(Circle())
    .scaleEffect(animationAmount)
}.padding()
```
When we say binding, the "$" sign comes to mind. As you can see, we can define the animation of the value as binding.

## Creating explicit animations
```swift
@State private var animationAmount = 0.0

Button("Tap Me") {
    withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
        animationAmount += 360
    }
}
.padding(50)
.background(.red)
.foregroundColor(.white)
.clipShape(Circle())
.rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
```
We have a trick here. Actually, if we don't use the withAnimation Tag, we get the same effect as a result. but bang! Apple gives us incredible comfort with such a closure.
