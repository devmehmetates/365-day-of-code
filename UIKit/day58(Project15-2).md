# Day 58 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day57-58/Day-57-58"> Project </a>

## Developing on Animations

## Subjects

+ Wrap Up
+ Challenges

## Challenges

+ Go back to project 8 and make the letter group buttons fade out when they are tapped. We were using the isHidden property, but you'll need to switch to alpha because isHidden is either true or false, it has no animatable values between.
+ Go back to project 13 and make the image view fade in when a new picture is chosen. To make this work, set the alpha to 0 first.
+ Go back to project 2 and make the flags scale down with a little bounce when pressed.


## Go back to project 8 and make the letter group buttons fade out when they are tapped. We were using the isHidden property, but you'll need to switch to alpha because isHidden is either true or false, it has no animatable values between. <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day36-38/Day36-38"> Project </a>
```swift
Let's start with the first step. 
UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) {
    sender.alpha = 0
} completion: { finished in

}
```
This code solves all our problems. Since I used the same code in several places, I will not repeat it. <a href="https://github.com/devmehmetates/365-day-of-code/commit/af215ae69c02192517071ca7c41f81eb4357a315">Changes</a>

## Go back to project 13 and make the image view fade in when a new picture is chosen. To make this work, set the alpha to 0 first. <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day52-54/Day52-54"> Project </a>

Here we will approach it differently. When selecting the picture, set the alpha to 0, then 1 again. Thus, the picture will appear as faded.
```swift
self.imageView.alpha = 0
UIView.animate(withDuration: 2, delay: 0, options: []) {
    self.imageView.alpha = 1
} completion: { finished in
    self.imageView.alpha = 1
}
```
Just that much. Add it in didFinishPickingMediaWithInfo.

## Go back to project 2 and make the flags scale down with a little bounce when pressed. <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day19-21/Day19-21"> Project </a>
Almost done.
```swift
@IBAction func buttonTabbed(_ sender: UIButton) {
    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: []) {
        sender.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
    } completion: { finished in

        var title : String

        if sender.tag == self.correctAnswer{
            title = "Correct"
            self.score += 1
            self.correct += 1
        }else{
            title = "Wrong choice\n" + "That's the flag of : \(self.countries[sender.tag])"
            self.score -= 1
        }

        let cc = UIAlertController(title: title, message: "Game is over\n Your score is: \(self.score)", preferredStyle: .alert)
        cc.addAction(UIAlertAction(title: "Reset the game", style: .default, handler: self.resetGame))

        let ac = UIAlertController(title: title, message: "Your score is: \(self.score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: self.askQuestion))


        if self.howMuchQuestion == 10{
            self.present(cc,animated: true)

        }else{
            self.present(ac,animated: true)

        }
    }
}
```
We showed the button that was pressed before as if it had fallen down.

```swift
self.button1.transform = .identity
self.button2.transform = .identity
self.button3.transform = .identity
```
And with the warnings that followed, we restored our buttons.

## Great Work :)

<img src="https://c.tenor.com/Bpv9wTLKMskAAAAC/computer-nerds.gif" width="700" height="500"/>


