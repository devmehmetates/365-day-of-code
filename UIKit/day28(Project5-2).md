# Day 28 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day27-29"> Project </a>

##  Word Game

### Subjects
 
+ Prepare for submission: lowercased() and IndexPath
+ Checking for valid answers
+ Or else what?

## Prepare for submission: lowercased() and IndexPath
Create two empty lists. Let's find the path of the file and read it line by line. Then let's add the words to the "allwords" array one by one. If we have a problem let's add a single word.
```swift
func isPossible (word: String) -> Bool{
    guard var tempWord = title?.lowercased() else {return false}

    for letter in word{
        if let position = tempWord.firstIndex(of: letter){
            tempWord.remove(at: position)
        }else{
            return true
        }
    }
    return true
}

func isOriginal (word : String) -> Bool{
    return !usedWords.contains(word)
}

func isReal(word : String) -> Bool{
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

    return misspelledRange.location == NSNotFound
}

```

## Checking for valid answers
```swift
func submit(_ answer: String) {
    let lowerAnswer = answer.lowercased()

    let errorTitle : String
    let errorMessage : String

    if isPossible(word: lowerAnswer) {
        if isOriginal(word: lowerAnswer){
            if isReal(word: lowerAnswer){
                usedWords.insert(answer, at: 0)

                let indexPath = IndexPath(row: 0, section: 0)
                tableView.insertRows(at: [indexPath], with: .automatic)
                return
            }else{
                errorTitle = "Word not recognized"
                errorMessage = "You can't just make them up, you know!"
            }
        }else{
            errorTitle = "Already Used"
            errorMessage = "Be more original"
        }
    }else{
        guard let title = title else{return}
        errorTitle = "word not possible"
        errorMessage = "You can't spell that word from \(title.lowercased())."
    }

    let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac,animated: true)

}
```
## Or else what?


```swift
let errorTitle : String
let errorMessage : String

let ac = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
ac.addAction(UIAlertAction(title: "OK", style: .default))
present(ac,animated: true)
```
