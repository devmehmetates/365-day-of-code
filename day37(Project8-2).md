# Day 37 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day36-38"> Project </a>

## Developing on Buttons and @objc Functions

## Subjects

+ Loading a level and adding button targets
+ It's play time: firstIndex(of:) and joined()
+ Property observers: didSet

## Loading a level and adding button targets
Let's start. First, let's copy our files to our project. And let's create some variables.

```swift
var activatedButtons = [UIButton]()
var solutions = [String]()

var score = 0 
var level = 1
```

```swift
func loadLevel(){
    var cluesString = ""
    var solutionString = ""
    var letterBits = [String]()

    if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt"){
        if let levelContent = try? String(contentsOf:levelFileURL){
            var lines = levelContent.components(separatedBy: "\n")
            lines.shuffle()

            for (index,line) in lines.enumerated(){
                let parts = line.components(separatedBy: ":")
                let answer = parts[0]
                let clue = parts[1]

                cluesString += "\(index + 1). \(clue)\n"
                let solutionsWord = answer.replacingOccurrences(of: "|", with: "")
                solutionString += "\(solutionsWord.count) letters \n"
                solutions.append(solutionsWord)

                let bits = answer.components(separatedBy: "|")
                letterBits += bits
            }

        }
    }

    cluesLabel.text = cluesString.trimmingCharacters(in: .whitespacesAndNewlines)
    answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)

    letterButtons.shuffle()

    if letterButtons.count == letterBits.count{
        for i in 0..<letterButtons.count{
            letterButtons[i].setTitle(letterBits[i], for: .normal)

        }
    }
}
```
This is quite a complex function. I'm summarizing what they've done.

+ Find my level texts and get us content line by line.
+ Separate the clues and syllables from the lines you find.
+ Fill in the clues texts.
+ And add texts indicating the length of the answer in the tags of the answers
+ Find the syllables with the pipe mark in the answer and add them.
+ Separate syllables and assign button names to these syllables


## It's play time: firstIndex(of:) and joined()
Now we will make our functions using 3 functions. These functions are slightly different from their previous functions.
```swift
// letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
@objc func letterTapped(_ sender: UIButton) {
      guard let buttonTitle = sender.titleLabel?.text else { return }

      currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
      activatedButtons.append(sender)
      sender.isHidden = true
  }
  
// submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
@objc func submitTapped(_ sender: UIButton) {
    guard let answerText = currentAnswer.text else { return }

    if let solutionPosition = solutions.firstIndex(of: answerText){
        activatedButtons.removeAll()

        var splitAnswer = answersLabel.text?.components(separatedBy: "\n")

        splitAnswer?[solutionPosition] = answerText
        answersLabel.text = splitAnswer?.joined(separator: "\n")

        currentAnswer.text = ""
        score += 1

        if score % 7 == 0 {
            let ac = UIAlertController(title: "Well done", message: "are you ready to next level", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "let's go", style: .default, handler: levelUp))
            present(ac,animated: true)
        }
    }
}
    
func levelUp(action : UIAlertAction? = nil){
    level += 1
    solutions.removeAll(keepingCapacity: true)
    loadLevel()

    for button in letterButtons {
        button.isHidden = false
    }

}

// clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
@objc func clearTapped(_ sender: UIButton) {
    currentAnswer.text = ""
    for button in activatedButtons {
        button.isHidden = false
    }

    activatedButtons.removeAll()
}
```
The whole code is above. But let's examine this difference over a function.
```swift
@objc func letterTapped(_ sender: UIButton) {
      guard let buttonTitle = sender.titleLabel?.text else { return }

      currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
      activatedButtons.append(sender)
      sender.isHidden = true
  }
``` 
If we remember, <code>@obcj</code> doesn't take a parameter in the functions before. But it's precisely the parameters that make our functions special. For example, an example letter function. What it does is actually very simple. It adds the text of the clicked button to the answer label. It calculates that the button is used and hides it.

Then let's examine the most important function.
```swift
@objc func submitTapped(_ sender: UIButton) {
    guard let answerText = currentAnswer.text else { return }

    if let solutionPosition = solutions.firstIndex(of: answerText){
        activatedButtons.removeAll()

        var splitAnswer = answersLabel.text?.components(separatedBy: "\n")

        splitAnswer?[solutionPosition] = answerText
        answersLabel.text = splitAnswer?.joined(separator: "\n")

        currentAnswer.text = ""
        score += 1

        if score % 7 == 0 {
            let ac = UIAlertController(title: "Well done", message: "are you ready to next level", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "let's go", style: .default, handler: levelUp))
            present(ac,animated: true)
        }
    }
}
```
As you can see, we also have a button parameter here. But we didn't use it. Here again an important issue comes into play. If we do not give this parameter, we cannot add a function to the button. Anyway, let's come to the function of our button. I will write them step by step.

+ assign our current answer to a variable if not empty
+ if this variable is available in our answers
+ Find the index of our answer clear our answer box and add the answer in the answer tag.
+ Increase the score
+ And check if the game is over.
+ If the game is over show a warning message.

## Property observers: didSet
Finally, there is a situation regarding state changes. It's pretty simple. A feature that runs when the variable is changed, determined, and allows it to be updated instantly on the screen. So <code>didSet</code>

```swift
var score = 0 {
    didSet {
        scoreLabel.text = "Score: \(score)"
    }
}
```
It's that simple.

## Happy Coding :)

<img src="https://c.tenor.com/sWEUdV5LQdkAAAAC/yes-apple.gif">










