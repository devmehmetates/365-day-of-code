# Day 57 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day57-58/Day-57-58"> Project </a>

## Developing on Animations

## Subjects

+ Set-Up
+ Preparing for action
+ Switch, case, animate: animate(withDuration:)
+ Transform: CGAffineTransform

### !! This file completely writing by me. So file can include some writing issue.
I trying improve to my english. Thanks for your understanding.

## Preparing for action
Let's create an iOS app. And quickly add an button on your storyboard. After, bind your button to viewController as action. Okay done! Go to viewController.swift.

```swift
var imageView: UIImageView!
var currentAnimation = 0
```
```swift
imageView = UIImageView(image: UIImage(named: "penguin"))
imageView.center = CGPoint(x: 512, y: 384)
view.addSubview(imageView)
```
We created an image, and set it point on screen. It's a penguin :)

## Switch, case, animate: animate(withDuration:)
Okay let's start some action. We will fill our tabbed function.
```swift
@IBAction func tapped(_ sender: UIButton) {
    sender.isHidden = true

    UIView.animate(withDuration: 1, delay: 0, options: [],
       animations: {
        switch self.currentAnimation {
        case 0:
            break

        default:
            break
        }
    }) { finished in
        sender.isHidden = false
    }

    currentAnimation += 1

    if currentAnimation > 7 {
        currentAnimation = 0
    }
}
```
Basicly this method will do it;
+ If button was tabbed and action continues hide button.
+ If action was done show again button.
+ Is it animation count bigger than seven? Reset animation count.

## Transform: CGAffineTransform
Okay. This section is real section. Let's move, rotate, zoom and change color our penguen. Obviousbly, This section exactly on tabbed func. What do this func do?
```swift
case .zero:
    self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
    break
case 1:
    self.imageView.transform = .identity
    break
```
This code provide zoom to penguen on first press. The second press will make the penguin zoomOut.
```swift
case 2:
    self.imageView.transform = CGAffineTransform(translationX: -256, y: -256)
    break
case 3:
    self.imageView.transform = .identity
    break
case 4:
    self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
    break
case 5:
    self.imageView.transform = .identity
    break
case 6:
    self.imageView.alpha = 0.1
    self.imageView.backgroundColor = UIColor.green
    break
case 7:
    self.imageView.alpha = 1
    self.imageView.backgroundColor = UIColor.clear
    break
```
It will go this way and in order;
+ Move penguen to northwest and move it back first location.
+ Rotate 180 degrees our penguen 2 times.
+ Change penguen color to green and after, clear it back to first color.

And last one. Change your animation type from default to spring.
```swift
UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: []) {
```
Is really cool animation type. But not better than easeInOut :D

## Happy Coding :)
Yes, so we finished the day. It's really good day for me. Great coding to all.

<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">

