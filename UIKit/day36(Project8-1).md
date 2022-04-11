# Day 36 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day36-38"> Project </a>

## Developing on Subviews - UIProperties - NSLayoutConstraint and UI Design on iPad

## Subjects

+ Set-Up
+ Building a UIKit user interface programmatically

## Building a UIKit user interface programmatically
There is a lot of code in this part, and if I throw them together it looks bad as an image. So let's take a look at them piece by piece.

First, let's create a few views and place them.
### Define
```swift
var cluesLabel : UILabel!
var answersLabel : UILabel!
var scoreLabel : UILabel!
```
### Create
```swift
override func loadView() {
    view = UIView()
    view.backgroundColor = .white

    scoreLabel = UILabel()
    scoreLabel.translatesAutoresizingMaskIntoConstraints = false
    scoreLabel.textAlignment = .right
    scoreLabel.text = "Score: 0"
    view.addSubview(scoreLabel)

    cluesLabel = UILabel()
    cluesLabel.translatesAutoresizingMaskIntoConstraints = false
    cluesLabel.font = UIFont.systemFont(ofSize: 24)
    cluesLabel.text = "CLUES"
    cluesLabel.numberOfLines = 0
    view.addSubview(cluesLabel)

    answersLabel = UILabel()
    answersLabel.translatesAutoresizingMaskIntoConstraints = false
    answersLabel.font = UIFont.systemFont(ofSize: 24)
    answersLabel.textAlignment = .right
    answersLabel.text = "ANSWERS"
    answersLabel.numberOfLines = 0
    view.addSubview(answersLabel)
}
```
### Place
```swift
NSLayoutConstraint.activate([
    scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
    scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),

    cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
    cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
    cluesLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6, constant: -100),

    answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
    answersLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:-100),
    answersLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4, constant: -100),
    answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
])
```
Since we use very similar things in other parts of the subject, I will not repeat them.

## Let's look at things that are different now.
Now, we are talking about adding another subview under the subview, unlike the others. So let's see.

First of all, we create a UIview like the page we have been working on so far.
```swift
let buttonView = UIView()
buttonView.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(buttonView) // Important
```
As you can see here we have added the current view as a subview. As like the others have. So why is this important? Let's take a look at these codes.

```swift
let width = 150
let heigth = 80

for row in 0..<4{
    for column in 0..<5{
        let letterButton = UIButton(type: .system)
        letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 36)
        letterButton.setTitle("www", for: .normal)

        let frame = CGRect(x: column * width, y: row * heigth, width: width, height: heigth)
        letterButton.frame = frame

        buttonView.addSubview(letterButton) // Here
        letterButtons.append(letterButton)
    }
}
```
Look at the line of code I specified. The process we're doing here is actually easy, but it's really quite important. Because we anchored the buttonview in the view. But the button we added on it complied with this fixation and there is no fixation in the added buttons. It will be able to do this by creating a view underneath. This is what makes it important.

## Note
Yes, the file was really long and that's why I didn't put it all here. And I really like to prepare documents whenever I have time. The entire file is in the header, if you want to browse the entire file, you can examine the viewController file there.

## Happy Coding :)

<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">










