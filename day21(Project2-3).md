# Day 21 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day19-21"> Project </a>

## Begin to the iOS

## Subjects

+ Wrap Up
+ Challenge

## Challenge

### Try showing the player’s score in the navigation bar, alongside the flag to guess.

```swift
 title = countries[correctAnswer].uppercased() + " - Current Score :" + String(score)
```
### Keep track of how many questions have been asked, and show one final alert controller after they have answered 10. This should show their final score.
```swift
var howMuchQuestion = 0
```

```swift
func askQuestion(action:UIAlertAction! = nil){
    howMuchQuestion += 1
```

```swift
let cc = UIAlertController(title: title, message: "Game is over\n Your score is: \(score)", preferredStyle: .alert)
cc.addAction(UIAlertAction(title: "Reset the game", style: .default, handler: resetGame))

if howMuchQuestion == 10{
  present(cc,animated: true)
}else{
  present(ac,animated: true)
}
```

### When someone chooses the wrong flag, tell them their mistake in your alert message – something like “Wrong! That’s the flag of France,” for example.

```swift
}else{
    title = "Wrong choice\n" + "That's the flag of : \(countries[sender.tag])"
    score -= 1
}
```

## Extra
Outside of the course, I added the game reset button.

```swift
func resetGame(action:UIAlertAction! = nil){
    score = 0
    howMuchQuestion = 0
    askQuestion()
}

cc.addAction(UIAlertAction(title: "Reset the game", style: .default, handler: resetGame)) // "cc" is defined a little above.
```

## Result

<img src="https://user-images.githubusercontent.com/74152011/150551823-2bb41d5b-e749-47b9-b087-3b9dacce492b.png" width=220> <img src="https://user-images.githubusercontent.com/74152011/150551870-2bd57cfa-b53c-4f52-930f-a92cc7046721.png" width=220> <img src="https://user-images.githubusercontent.com/74152011/150551897-f4655cd8-616c-479e-ba64-01d87ec20ffd.png" width=220> <img src="https://user-images.githubusercontent.com/74152011/150551903-c65b95cd-552f-4fd5-bc86-4c219e339c13.png" width=220>
