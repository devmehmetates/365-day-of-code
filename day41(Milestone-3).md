# Day 41 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day41-Challenge"> Project </a>

##  Hangman Game

+ Challenge

## Challenge
Let's Code Hangman Game

## First Step - Let's code the buttons that make up all the letters.
```swift
var allLetters = [String]()
var letterButtonView : UIView!

...
for char in "abcdefghijklmnopqrstuvwxyz" {
    let appendChar = char.uppercased()
    allLetters.append(appendChar)
}

letterButtonView = UIView()
letterButtonView.translatesAutoresizingMaskIntoConstraints = false
view.addSubview(letterButtonView)

let width = 50
let heigth = 40
var row = 0
var column = 0

for (index,letter) in allLetters.enumerated() {
    if index != 0 {
        column += 1
        if index % 6 == 0{
            row += 1
            column = 0
        }
    }

    let letterButton = UIButton(type: .system)
    letterButton.setTitle(String(letter), for: .normal)
    let frame = CGRect(x: column * width, y: row * heigth, width: width, height: heigth)
    letterButton.frame = frame
    letterButton.addTarget(self, action: #selector(buttonTabbed), for: .touchUpInside)
    letterButtonView.addSubview(letterButton)
}
...
```
This code creates the buttons, arranges them side by side and one under the other, and sets their titles as letters.

## Second Step - Create Current Answer
```swift
var userAnswer = ""{
    didSet{
        userAnswerLabel.text = userAnswer
    }
}
var userAnswerLabel : UILabel!

...
userAnswerLabel = UILabel()
userAnswerLabel.translatesAutoresizingMaskIntoConstraints = false
userAnswerLabel.textAlignment = .center
userAnswerLabel.font = UIFont.systemFont(ofSize: 40)
userAnswerLabel.text = userAnswer
view.addSubview(userAnswerLabel)

for _ in 0..<answer.count{
    userAnswer += "?"
}
...
```
Here, a question mark as long as our answer is printed on the screen.

## Third Step - What happened on button tapped 🤯
```swift
@objc func buttonTabbed(_ sender : UIButton){
    if !usedLetters.contains((sender.titleLabel?.text)!){
        userAnswer = ""
        for (index,answerLetter) in answer.enumerated(){
            if sender.titleLabel?.text == String(answerLetter){
                userAnswer += String(answerLetter)
                correctIndexs[index] = String(answerLetter)
                continue
            }
            if correctIndexs.keys.contains(index){
                userAnswer += correctIndexs[index]!
                continue
            }
            userAnswer += "?"
        }

        if correctIndexs.values.contains((sender.titleLabel?.text)!.uppercased()) {
            score += 1
        }else{
            score -= 1
            wrongAnswers += 1
        }

        sender.isEnabled = false
        usedLetters.append((sender.titleLabel?.text)!)
    }

    if wrongAnswers == 7{
        self.showAlert(title: "You died!", message: "Try Again!", passed: false)
    }

    if !userAnswer.contains("?"){
        self.showAlert(title: "Passed!", message: "Let's Go!", passed: true)
    }
}
```
This place is really complicated. So I will try to explain it in points.
+ If we do not have letters in the words used
+ Reset our answer and check if the word contains this letter. Save each containing word with its index.
+ If there are already opened letters take them and replace them otherwise "?" write and continue.
+ If the correct guess is correct, add a score, if incorrect, both reduce the score and add a wrong answer.
+ If wrong answers reach 7, finish the level. If the level is over without dying, go to the new level

## Finish
```swift
func showAlert(title : String, message : String? = nil, passed: Bool? = false){
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    if passed!{
        ac.addAction(UIAlertAction.init(title: "Go Next", style: .default, handler: levelUP))
    }else{
        ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: restartLevel))
    }

    present(ac,animated: true)
}

func restartLevel(action : UIAlertAction? = nil){
    self.resetScreen()
}

func levelUP(action : UIAlertAction? = nil){
    if self.levels.count - 1 > self.currentLevel{
        self.currentLevel += 1
        resetScreen()
    }else{
        showAlert(title: "Game Over", message: "Your Score: \(score)\nMaybe you wanna replay this level?", passed: false)
    }
}

func resetScreen(){
    self.userAnswer = ""
    for _ in 0..<answer.count{
        self.userAnswer += "?"
    }
    self.wrongAnswers = 0
    self.usedLetters.removeAll()
    self.correctIndexs.removeAll()
    for subViews in letterButtonView.subviews{
        guard let button = subViews as? UIButton else { return }
        button.isEnabled = true
    }
}
```
Here, I am writing the functions that we will use above. I don't need to explain, I think everything is clear from their names anyway.

## Great Work :)

<img src="https://c.tenor.com/Bpv9wTLKMskAAAAC/computer-nerds.gif" width="500" height="300"/>

