# Day 29 <a href="https://github.com/devmehmetates/365-day-of-code/tree/main/Project/Day27-29"> Project </a>

##  Challenge

### Subjects
 
+ Reject words shorter than 2 letters in length
+ Reject if the entered word is the same as the game word
+ Create an error message func
+ Create reset game button
+ Bug Fix

## Reject words shorter than 2 letters in length
```swift
func isReal(word : String) -> Bool{
    let checker = UITextChecker()
    let range = NSRange(location: 0, length: word.utf16.count)

    // Add here
    if range.length < 3{
        return false
    }
   
    let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")

    return misspelledRange.location == NSNotFound
}
```

## Reject if the entered word is the same as the game word
```swift
func isOriginal (word : String) -> Bool{
    if word.lowercased() == title?.lowercased(){
        return false
    }
}
```
## Create an error message func
```swift
func showErrorMessage(title : String, message : String){
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    ac.addAction(UIAlertAction(title: "OK", style: .default))
    present(ac,animated: true)
}
```
## Create reset game button
```swift
navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resetGame))
@objc func resetGame(){
    startGame()
}
```
## Bug Fix
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
```

