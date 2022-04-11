# Day 38 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day36-38"> Project </a>

## Developing on Subviews - UIProperties - NSLayoutConstraint and UI Design on iPad

## Subjects

+ Wrap Up
+ Challenges

## Challenges
Let's solve today's challenges.

+ Use the techniques you learned in project 2 to draw a thin gray line around the buttons view, to make it stand out from the rest of the UI.
+ If the user enters an incorrect guess, show an alert telling them they are wrong. You’ll need to extend the submitTapped() method so that if firstIndex(of:) failed to find the guess you show the alert.
+ Try making the game also deduct points if the player makes an incorrect guess. Think about how you can move to the next level – we can’t use a simple division remainder on the player’s score any more, because they might have lost some points.

### Use the techniques you learned in project 2 to draw a thin gray line around the buttons view, to make it stand out from the rest of the UI.
What is said here is quite simple. Of course <code>CALayer</code>CALayer.

```swift
buttonView.layer.borderWidth = 1
buttonView.layer.borderColor = UIColor.gray.cgColor
```
Here's how it's done.

### If the user enters an incorrect guess, show an alert telling them they are wrong. You’ll need to extend the submitTapped() method so that if firstIndex(of:) failed to find the guess you show the alert.
Yes, we are not doing anything difficult here, actually.
```swift
...
}else{
    let wrAc = UIAlertController(title: "Wrong Anwswer", message: "Try Again", preferredStyle: .alert)
    wrAc.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
    present(wrAc,animated: true)
    clearTapped(nil)
    score -= 1
}
...
```
All we do is decrement an alertcontroller and score.

### Try making the game also deduct points if the player makes an incorrect guess. Think about how you can move to the next level – we can’t use a simple division remainder on the player’s score any more, because they might have lost some points.

This is where the fun starts. Let's end the game by my own rules.

```swift
...
score += 1

var levelEnd = true
for lebutton in letterButtons {
    if lebutton.isHidden == false{
        levelEnd = false
        break
    }
}

if levelEnd{
    if score > 4{
        showLevelAlert(title: "Well Done", message: "Are you ready to next level?",buttonTitle: "Let's Go!")
    }else{
        showLevelAlert(title: "Level not completed", message: "Maybe next time?", buttonTitle: "Try Again!")
    }
}
...
```
Now let me explain these lines to you. How do I know that the level is completed despite the decrease in points I first asked?<br> <code>From their hiding</code> <br>

If the level is over and the score is below 4, it means that we have made more than 3 mistakes. Then show us that we failed. If our score is more than 4, send it to the new level. But how about replaying to our current level?

```swift
func showLevelAlert(title : String, message : String?, buttonTitle : String){
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    if title == "Well Done"{
        ac.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: levelUp))
    }else{
        ac.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: resetLevel))
    }
    present(ac,animated: true)
}
```
This is my refactoring code. It provides more layout and prevents code duplication. Here we determine which stimulus is the warning that will show when the level is completed. Of course, we create and show that alert.

Finally, we have leveling up. but if we fail our game will be broken? Here is our function to reset our current level.
```swift
func resetLevel(action : UIAlertAction? = nil){
    solutions.removeAll(keepingCapacity: true)
    score = 0
    loadLevel()

    for button in letterButtons {
        button.isHidden = false
    }

}
```
What if the game is started without leveling up and restoring everything? :)

## Happy Coding :)

<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">










