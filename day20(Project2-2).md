# Day 20 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day19-21"> Project </a>

## Begin to the iOS

## Subjects

+ Guess which flag: random numbers
+ From outlets to actions: creating an IBAction

## Guess which flag: random numbers
Let's shuffle our list and set a correct answer after each shuffle.

```swift
var correctAnswer = 0

countries.shuffle()
correctAnswer = Int.random(in: 0...2)
```

And sync the title to the correct answer
```swift
 title = countries[correctAnswer].uppercased() 
```

## From outlets to actions: creating an IBAction
What we're doing here is to show whether the correct answer is pressed using a single function and button tags.

```swift
@IBAction func buttonTabbed(_ sender: UIButton) {
    var title : String

    if sender.tag == correctAnswer{
        title = "Correct"
        score += 1
    }else{
        title = "Wrong"
        score -= 1
    }
}
```

Here, we show a warning to the user based on the response given.
```swift
let ac = UIAlertController(title: title, message: "Your score is: \(score)", preferredStyle: .alert)
ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))

present(ac,animated: true)
```

Xcode gives an error before this edit for "handle" line above.<br>
Because here it is requested to accept the UIAlertAction parameter. We add it and cast nil as a constant.<br>
So we don't have to constantly enter nil when we don't need to enter a value when using the function
```swift
func askQuestion(action:UIAlertAction! = nil){
```
